//
//  Resolver.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/**
 Responsible for creating the resulting DAG and performing core validation/resolution steps.
 */
public struct Resolver {
    /// Resolves and validates all root components in the provided `LinkedInterface`.
    ///
    /// - parameter interface: `LinkedInterface` used to perform resolution.
    /// - returns: List of all root components as `ResolvedComponent` instances.
    ///
    public static func resolve(interface: LinkedInterface) -> [ResolvedComponent] {
        let modulesByName = interface.modules.reduce(into: [String:LinkedModule]()) { (dict, module) in
            if let _ = dict[module.type] {
                print("Warning: Duplicate module definitions for \(module.type). Should disambiguate.")
            }
            dict[module.type] = module
        }
        let componentsByName = interface.components.reduce(into: [String:LinkedComponent]()) { (dict, c) in
            if let _ = dict[c.type] {
                print("Warning: Duplicate component definitions for \(c.type). Should disambiguate.")
            }
            dict[c.type] = c
        }
        
        var diagnostics: [ResolutionError] = []
        return interface.components.filter { $0.isRoot }.map { resolve(component: $0, modulesByName: modulesByName, componentsByName: componentsByName, diagnostics: &diagnostics)}
    }
}

fileprivate extension Resolver {
    // Helper object for exposing bindings created in ancestor scopes.
    class ComponentBindings {
        let parent: ComponentBindings?
        let providersByType: [String:[CanonicalProvider]]
        
        init(providersByType: [String:[CanonicalProvider]], parent: ComponentBindings? = nil) {
            self.providersByType = providersByType
            self.parent = parent
        }
        
        func provider(for type: String) -> CanonicalProvider? {
            return providersByType[type]?.first ?? parent?.provider(for: type)
        }
    }
    
    static func resolve(component: LinkedComponent, modulesByName: [String:LinkedModule], componentsByName: [String:LinkedComponent], parentBindings: ComponentBindings? = nil, diagnostics: inout [ResolutionError]) -> ResolvedComponent {
        let allModules = resolveModules(
            modulesByName, in: component,
            diagnostics: &diagnostics
        )
        let allSubcomponents = resolveSubcomponents(
            componentsByName,
            in: component,
            with: allModules,
            diagnostics: &diagnostics
        )
        
        let providersByType = createUniqueProvidersMap(
            in: component,
            includedModules: allModules,
            installedSubcomponents: allSubcomponents,
            diagnostics: &diagnostics
        )
        
        let componentBindings = ComponentBindings(providersByType: providersByType, parent: parentBindings)
        
        // Added dependency is the component's `rootType`. We need to make sure there is a binding for the root object.
        resolveDependencies(for: componentBindings, additionalDependencies: [component.rootType], diagnostics: &diagnostics)
        let children = allSubcomponents.map { resolve(component: $0, modulesByName: modulesByName, componentsByName: componentsByName, parentBindings: componentBindings, diagnostics: &diagnostics) }
        
        let resolvedComponent = ResolvedComponent(
            type: component.type,
            providersByType: providersByType,
            children: children,
            diagnostics: diagnostics)
        
        children.forEach { (child) in
            child.parent = resolvedComponent
        }
        
        return resolvedComponent
    }
    
    static func resolveDependencies(for bindings: ComponentBindings, additionalDependencies: [String], diagnostics: inout [ResolutionError]) {
        let dependencies = bindings.providersByType.flatMap { $0.value }.filter { !$0.isLazyProvider} .flatMap { $0.dependencies } + additionalDependencies
        dependencies.forEach { (dependency) in
            if bindings.provider(for: dependency) == nil {
                diagnostics.append(ResolutionError(type: .missingProvider(dependency)))
            }
        }
    }
    
    static func createUniqueProvidersMap(in component: LinkedComponent, includedModules: [LinkedModule], installedSubcomponents: [LinkedComponent], diagnostics: inout [ResolutionError]) -> [String:[CanonicalProvider]] {
        var allCanonicalProviders = (component.providers + includedModules.flatMap { $0.providers}).map { $0.mapToCanonical() }
        allCanonicalProviders.append(component.seedProvider)
        allCanonicalProviders.append(contentsOf: installedSubcomponents.map { $0.componentFactoryProvider} )
        
        return allCanonicalProviders.reduce(into: [String:[CanonicalProvider]](), { (dict, provider) in
            if let existing = dict[provider.type] {
                if !provider.isCollectionProvider || !existing.allSatisfy({ (p) -> Bool in
                    p.isCollectionProvider == provider.isCollectionProvider
                }) {
                    diagnostics.append(ResolutionError(type: .duplicateProvider(provider.type)))
                } else {
                    dict[provider.type]!.append(provider)
                }
            } else {
                dict[provider.type] = [provider]
                dict[provider.lazyProvider.type] = [provider.lazyProvider]
            }
        })
    }

    // Resolves all directly and transitively included modules in a given component.
    static func resolveModules(_ modulesByName: [String:LinkedModule], in component: LinkedComponent, diagnostics: inout [ResolutionError]) -> [LinkedModule] {
        var seenModules = Set(component.includedModules)
        var moduleSearchQueue = Array(seenModules)
        var foundModules: [LinkedModule] = []
        
        while !moduleSearchQueue.isEmpty {
            let top = moduleSearchQueue.remove(at: 0)
            if let foundModule = modulesByName[top] {
                foundModules.append(foundModule)
                let uniqueIncludedModules = Set(foundModule.includedModules).subtracting(seenModules)
                seenModules.formUnion(uniqueIncludedModules)
                moduleSearchQueue.append(contentsOf: uniqueIncludedModules)
            } else {
                diagnostics.append(ResolutionError(type: .missingModule(top)))
            }
        }
        
        return foundModules
    }
    
    static func resolveSubcomponents(_ componentsByName: [String:LinkedComponent], in component: LinkedComponent, with modules: [LinkedModule], diagnostics: inout [ResolutionError]) -> [LinkedComponent] {
        var seenComponents = Set(component.subcomponents)
        var componentSearchQueue = Array(seenComponents)
        var foundSubcomponents: [LinkedComponent] = []
        
        while !componentSearchQueue.isEmpty {
            let top = componentSearchQueue.remove(at: 0)
            if let foundModule = componentsByName[top] {
                foundSubcomponents.append(foundModule)
                let uniqueInstalledSubcomponents = Set(foundModule.subcomponents).subtracting(seenComponents)
                seenComponents.formUnion(uniqueInstalledSubcomponents)
                componentSearchQueue.append(contentsOf: uniqueInstalledSubcomponents)
            } else {
                diagnostics.append(ResolutionError(type: .missingSubcomponent(top)))
            }
        }
        
        return foundSubcomponents
    }
}