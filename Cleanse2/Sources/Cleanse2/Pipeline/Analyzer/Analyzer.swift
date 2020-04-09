//
//  Analyzer.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

struct AnalyzerResults {
    let rootNodes: [ComponentNode]
    let diagnostics: [Diagnostic]
}

struct Analyzer {
    private let fileResults: [FileResults]
    init(fileResults: [FileResults]) {
        self.fileResults = fileResults
    }
    
    func finalize() -> AnalyzerResults {
        var rootNodes: [ComponentNode] = []
        
        // Form modules by name
        let modulesByName: [TypedKey:ModuleResults]
        let componentsByName: [TypedKey:ComponentResults]
        do {
            modulesByName = try validateUniqueModuleNames()
            componentsByName = try validateUniqueComponentNames()
        } catch {
            return AnalyzerResults(rootNodes: [], diagnostics: [error as! Diagnostic])
        }
        
        
        var componentNodesByName: [TypedKey:ComponentNode] = [:]
        var diagnostics: [Diagnostic] = []
        componentsByName.forEach { args in
            let (name, result) = args
            let node = componentNodesByName[name] ?? ComponentNode(name: name, root: result.root)
            componentNodesByName[name] = node
            
            // Relationships
            if let p = result.parent {
                if let parentNode = componentNodesByName[p] {
                    parentNode.children.append(node)
                } else {
                    let newParentNode = ComponentNode(name: p, root: result.root)
                    newParentNode.children.append(node)
                    componentNodesByName[p] = newParentNode
                }
            } else {
                rootNodes.append(node)
            }
            
            // Providers
            node.providersInfoByType = result.modules.reduce(into: [TypedKey:Provider]()) { (aggregate, moduleName) in
                guard let moduleResult = modulesByName[moduleName] else {
                    diagnostics += [Diagnostic(type: .error, scope: .component(node.name), description: "Failed to find module definition: \(moduleName.rawRepresentation).")]
                    return
                }
                aggregate.merge(moduleResult.providersByType) { (a, _) -> Provider in
                    let error = Diagnostic(type: .error, scope: .provider(a.type), description: "Found duplicate providers for type: \(a.type.rawRepresentation).")
                    diagnostics += [error]
                    return a
                }
            }
        }
        
        return AnalyzerResults(rootNodes: rootNodes, diagnostics: diagnostics)
    }
    
    private func validateUniqueModuleNames() throws -> [TypedKey:ModuleResults] {
        return try fileResults.reduce(into: [TypedKey:ModuleResults]()) { (aggregate, result) in
            try aggregate.merge(result.moduleResultsByName) { (a, _) -> ModuleResults in
                throw Diagnostic(type: .fatal, scope: .singleton, description: "Found duplicate module definition: \(a.module.rawRepresentation)")
            }
        }
    }
    
    private func validateUniqueComponentNames() throws -> [TypedKey:ComponentResults] {
        return try fileResults.reduce(into: [TypedKey:ComponentResults]()) { (aggregate, result) in
            try aggregate.merge(result.componentResultsByName) { (a, _) -> ComponentResults in
                let error = Diagnostic(type: .fatal, scope: .singleton, description: "Found duplicate component definition: \(a.name.rawRepresentation)")
                throw error
            }
        }
    }
    
}
