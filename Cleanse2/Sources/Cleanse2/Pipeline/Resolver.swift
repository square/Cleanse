//
//  Resolver.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

struct ResolvedProviderDependency {
    let parentDepth: Int
    let info: ProviderInfo
}

struct ResolvedProvider {
    let type: NormalizedTypeSyntax
    let info: ProviderInfo
    let resolvedDependencies: [ResolvedProviderDependency]
}

struct ResolvedComponent {
    let name: String
    let resolvedProviders: [ResolvedProvider]
    let root: ResolvedProvider
    let parent: String?
}

struct Resolver {
    private let roots: [ComponentNode]
    init(roots: [ComponentNode]) {
        self.roots = roots
    }
    
    func finalize() throws -> [ResolvedComponent] {
        var seenNodes = Set<ComponentNode>()
        var resolvedNodes: [ResolvedComponent] = []
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
                throw CleanseError()
            }
            let rootResolvedProvider = ResolvedProvider(
                type: node.root,
                info: rootProviderInfo,
                resolvedDependencies: [])
            
            let resolvedProviders = node.providersInfoByType.map { (args) -> Result<ResolvedProvider, CleanseError> in
                let (type, info) = args
                let resolvedDependencies = info.dependencies.map { (type) in
                    self.resolve(dependency: type, in: node)
                }
                
                guard resolvedDependencies.allSatisfy({ (dependency) -> Bool in
                    dependency != nil
                }) else {
                    return .failure(CleanseError())
                }
                
                return .success(ResolvedProvider(type: type, info: info, resolvedDependencies: resolvedDependencies.map { $0! }))
            }
            
            if resolvedProviders.allSatisfy({ (result) -> Bool in
                switch result {
                case .success:
                    return true
                case .failure:
                    return false
                }
            }) {
                let finalResolved = resolvedProviders.map { provider -> ResolvedProvider in
                    switch provider {
                    case .success(let p):
                        return p
                    case .failure(_):
                        fatalError("Should not happen due to allSatisfy")
                    }
                }
                return [ResolvedComponent(name: node.name, resolvedProviders: finalResolved, root: rootResolvedProvider, parent: node.parent?.name)]
            } else {
                throw CleanseError()
            }
        }
        
        return resolvedNodes
    }
    
    private func resolve(dependency type: NormalizedTypeSyntax, in component: ComponentNode?, depth: Int = 0) -> ResolvedProviderDependency? {
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
