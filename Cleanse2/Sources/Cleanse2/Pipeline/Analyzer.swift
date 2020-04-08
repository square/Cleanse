//
//  Analyzer.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

class ComponentNode: Hashable {
    static func == (lhs: ComponentNode, rhs: ComponentNode) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    let name: String
    let root: NormalizedTypeSyntax
    weak var parent: ComponentNode?
    var children: [ComponentNode] = []
    var providersInfoByType: [NormalizedTypeSyntax:ProviderInfo] = [:]
    
    init(name: String, root: NormalizedTypeSyntax) {
        self.name = name
        self.root = root
    }
    
}

struct Analyzer {
    private let fileResults: [FileResults]
    init(fileResults: [FileResults]) {
        self.fileResults = fileResults
    }
    
    // Array of root components. Array of disjoint DAGs.
    func finalize() throws -> [ComponentNode] {
        var rootNodes: [ComponentNode] = []
        let modulesByName = try validateUniqueModuleNames()
        let componentsByName = try validateUniqueComponentNames()
        
        var componentNodesByName: [String:ComponentNode] = [:]
        
        try componentsByName.forEach { args in
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
            node.providersInfoByType = try result.modules.reduce(into: [NormalizedTypeSyntax:ProviderInfo]()) { (aggregate, moduleName) in
                guard let moduleResult = modulesByName[moduleName] else {
                    throw CleanseError()
                }
                try aggregate.merge(moduleResult.providersByType) { (_, _) -> ProviderInfo in
                    throw CleanseError()
                }
            }
        }
        
        return rootNodes
    }
    
    private func validateUniqueModuleNames() throws -> [String:ModuleResults] {
        return try fileResults.reduce(into: [String:ModuleResults]()) { (aggregate, result) in
            try aggregate.merge(result.moduleResultsByName) { (_, _) -> ModuleResults in
                throw CleanseError()
            }
        }
    }
    
    private func validateUniqueComponentNames() throws -> [String:ComponentResults] {
        return try fileResults.reduce(into: [String:ComponentResults]()) { (aggregate, result) in
            try aggregate.merge(result.componentResultsByName) { (_, _) -> ComponentResults in
                throw CleanseError()
            }
        }
    }
    
}
