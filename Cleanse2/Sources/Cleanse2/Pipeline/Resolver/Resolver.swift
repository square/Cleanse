//
//  Resolver.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

struct ResolverResults {
    let resolvedComponents: [ResolvedComponent]
    let diagnostics: [Diagnostic]
}

struct Resolver {
    private let roots: [ComponentNode]
    init(roots: [ComponentNode]) {
        self.roots = roots
    }
    
    func finalize() -> ResolverResults {
        var seenNodes = Set<ComponentNode>()
        var resolvedNodes: [ResolvedComponent] = []
        var diagnostics: [Diagnostic] = []
        var queue = roots
        while !queue.isEmpty {
            let node = queue.removeFirst()
            if queue.contains(node) {
                continue
            }
            defer {
                seenNodes.insert(node)
                queue.append(contentsOf: node.children)
            }
            
            guard let rootProviderInfo = node.providersInfoByType[node.root] else {
                diagnostics += [Diagnostic(type: .error, scope: .component(node.name), description: "Missing root provider \(node.root.rawRepresentation) for component \(node.name.rawRepresentation)")]
                continue
            }
            let rootResolvedProvider = ResolvedProvider(
                type: node.root,
                info: rootProviderInfo,
                resolvedDependencies: [])
            
            let resolvedProviders = node.providersInfoByType.map { (args) -> ResolvedProvider in
                let (type, info) = args
                
                let resolvedDependencies = info.dependencies.compactMap { self.resolve(dependency: $0, in: node) }
                guard resolvedDependencies.count == info.dependencies.count else {
                    resolvedDependencies.map { $0.info.type }.difference(from: info.dependencies).forEach { (missingType) in
                        diagnostics.append(Diagnostic(
                            type: .error,
                            scope: .provider(type),
                            description: "Missing dependency type \(missingType.rawRepresentation) for provider \(type.rawRepresentation)"))
                    }
                    
                    return ResolvedProvider(type: type, info: info, resolvedDependencies: [])
                }
                return ResolvedProvider(type: type, info: info, resolvedDependencies: resolvedDependencies)
            }
            
            resolvedNodes.append(
                ResolvedComponent(
                    name: node.name,
                    resolvedProviders: resolvedProviders,
                    root: rootResolvedProvider,
                    parent: node.parent?.name,
                    subcomponents: node.children.map { $0.name }
                )
            )
        }
        
        return ResolverResults(resolvedComponents: resolvedNodes, diagnostics: diagnostics)
    }
    
    private func resolve(dependency type: TypedKey, in component: ComponentNode?, depth: Int = 0) -> ResolvedProviderDependency? {
        guard let c = component else {
            return nil
        }
        if let info = c.providersInfoByType[type] {
            return ResolvedProviderDependency(parentDepth: depth, info: info)
        } else {
            return resolve(dependency: type, in: c.parent, depth: depth + 1)
        }
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
