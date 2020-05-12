//
//  Linker.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/**
 The Linker is repsonsible for linking `ReferenceProvider` instances to their respective `DanglingProvider`.
 */
public struct Linker {
    /// Links all the reference providers to their dangling providers.
    ///
    /// - parameter modules: List of `ModuleRepresentation` instances to link all providers.
    /// - returns: `LikedInterface` instance with all modules, components, and linked `StandardProvider` instances.
    ///
    public static func link(modules: [ModuleRepresentation]) -> LinkedInterface {
        let files = modules.flatMap { $0.files }
        return link(files: files)
    }
    
    private static func link(files: [FileRepresentation]) -> LinkedInterface {
        let components = files.flatMap { $0.components }
        let modules = files.flatMap { $0.modules }
        let danglingProviders = components.flatMap { $0.danglingProviders } + modules.flatMap { $0.danglingProviders }
        let danglingProvidersByReference = danglingProviders.reduce(into: [String:DanglingProvider]()) { (dict, provider) in
            if let _ = dict[provider.reference] {
                print("Warning: Duplicate dangling provider reference: \(provider.reference)")
            }
            dict[provider.reference] = provider
        }
        
        let linkedComponents = components.map { component -> LinkedComponent in
            let linkedProviders = link(
                referenceProviders: component.referenceProviders,
                danglingProvidersByReference: danglingProvidersByReference
            )
            let allProviders = component.providers + linkedProviders
            return LinkedComponent(
                type: component.type,
                rootType: component.rootType,
                providers: allProviders,
                seed: component.seed,
                includedModules: component.includedModules,
                subcomponents: component.subcomponents,
                isRoot: component.isRoot
            )
        }
        
        let linkedModules = modules.map { module -> LinkedModule in
            let linkedProviders = link(
                referenceProviders: module.referenceProviders,
                danglingProvidersByReference: danglingProvidersByReference
            )
            let allProviders = module.providers + linkedProviders
            return LinkedModule(
                type: module.type,
                providers: allProviders,
                includedModules: module.includedModules,
                subcomponents: module.subcomponents
            )
        }
        
        return LinkedInterface(
            components: linkedComponents,
            modules: linkedModules
        )
    }
    
    private static func link(referenceProviders: [ReferenceProvider], danglingProvidersByReference: [String:DanglingProvider]) -> [StandardProvider] {
        return referenceProviders.compactMap { referenceProvider -> StandardProvider? in
            guard let linked = danglingProvidersByReference[referenceProvider.reference] else {
                print("Warning: Failed to find pointee for reference provider: \(referenceProvider)")
                return nil
            }
            return StandardProvider(
                type: referenceProvider.type,
                dependencies: linked.dependencies,
                tag: referenceProvider.tag,
                scoped: referenceProvider.scoped,
                collectionType: referenceProvider.collectionType
            )
        }
    }
}
