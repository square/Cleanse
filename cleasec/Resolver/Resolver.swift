//
//  Resolver.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/24/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct Resolver {
    public static func resolve(rootComponent: LinkedComponent, in interface: LinkedInterface) -> ResolvedComponent {
        let modulesByName = interface.modules.reduce(into: [String:LinkedModule]()) { (dict, module) in
            if let _ = dict[module.type] {
                print("Warning! Duplicate module definitions for \(module.type). Should disambiguate.")
            }
            dict[module.type] = module
        }
        
        let componentsByName = interface.components.reduce(into: [String:LinkedComponent]()) { (dict, c) in
            if let _ = dict[c.type] {
                print("Warning! Duplicate component definitions for \(c.type). Should disambiguate.")
            }
            dict[c.type] = c
        }
        
        return resolve(component: rootComponent, modulesByName: modulesByName, componentsByName: componentsByName, parent: nil)
    }
    
    private static func resolve(component: LinkedComponent, modulesByName: [String:LinkedModule], componentsByName: [String:LinkedComponent], parent: ResolvedComponent? = nil) -> ResolvedComponent {
        var seenModules = Set<String>()
        var diagnostics: [ResolutionError] = []
        Set(component.includedModules).subtracting(Set(modulesByName.keys)).forEach { (missingModule) in
            diagnostics.append(ResolutionError(error: .missingModule(missingModule)))
        }
        let foundModules = component.includedModules.compactMap { modulesByName[$0] }
        let moduleResults = foundModules.map { recursivelyFlattenProviders(in: $0, modulesByName: modulesByName, seenModules: &seenModules) }
        let moduleProviders = moduleResults.flatMap { $0.providers }
        let moduleSubcomponents = moduleResults.flatMap { $0.subcomponents }
        let moduleDiagnostics = moduleResults.flatMap { $0.diagnostics }
        
        let allProviders = component.providers + moduleProviders
        let allSubcomponents = (component.subcomponents + moduleSubcomponents).uniques
        var allDiagnostics = diagnostics + moduleDiagnostics
        
        let allCanonicalProviders = allProviders.map { $0.mapToCanonicalProvider() }
        var providersByType = allCanonicalProviders.reduce(into: [String:[CanonicalProvider]]()) { (dict, provider) in
            if var existing = dict[provider.type] {
                if existing.contains(where: { !$0.isCollection }) || !provider.isCollection {
                    allDiagnostics += [ResolutionError(error: .duplicateDependency(provider.type))]
                } else {
                    existing.append(provider)
                    dict[provider.type] = existing
                    dict[provider.lazyProvider.type] = [provider.lazyProvider]
                }
            } else {
                dict[provider.type] = [provider]
                dict[provider.lazyProvider.type] = [provider.lazyProvider]
            }
        }
        
        // Add ComponentFactory providers
        allSubcomponents
            .map { CanonicalProvider(type: "ComponentFactory<\($0)>", dependencies: [], isCollection: false) }
            .forEach { (provider) in
                providersByType[provider.type] = [provider]
            }
        
        let resolvedComponent = ResolvedComponent(
            type: component.type,
            parent: parent,
            providersByType: providersByType,
            diagnostics: []
        )
        
        // Dependency validation
        allCanonicalProviders.flatMap { $0.dependencies }.forEach { (dependency) in
            if resolveDependency(type: dependency, in: resolvedComponent).isEmpty {
                allDiagnostics.append(ResolutionError(error: .missingDependency(dependency)))
            }
        }
        
        Set(allSubcomponents).subtracting(Set(componentsByName.keys)).forEach { (missingComponent) in
            diagnostics.append(ResolutionError(error: .missingComponent(missingComponent)))
        }
        let foundSubcomponents = allSubcomponents.compactMap { componentsByName[$0] }
        let childComponents = foundSubcomponents.map { (subcomponent) in
            return resolve(component: subcomponent, modulesByName: modulesByName, componentsByName: componentsByName, parent: resolvedComponent)
        }
        resolvedComponent.children = childComponents
        let childDiagnostics = childComponents.flatMap { $0.diagnostics }
        resolvedComponent.diagnostics = allDiagnostics + childDiagnostics
        
        return resolvedComponent
    }
    
    private static func resolveDependency(type: String, in resolvedComponent: ResolvedComponent?) -> [CanonicalProvider] {
        guard let c = resolvedComponent else {
            return []
        }
        return c.providersByType[type] ?? resolveDependency(type: type, in: c.parent)
    }
    
    private static func recursivelyFlattenProviders(in module: LinkedModule, modulesByName: [String:LinkedModule], seenModules: inout Set<String>) -> ModuleSearchResult {
        if seenModules.contains(module.type) {
            return ModuleSearchResult.empty
        }
        seenModules.insert(module.type)
        
        // Missing modules
        var diagnostics: [ResolutionError] = []
        Set(module.includedModules).subtracting(Set(modulesByName.keys)).forEach { (missingModule) in
            diagnostics.append(ResolutionError(error: .missingModule(missingModule)))
        }
        
        let foundModules = module.includedModules.compactMap { modulesByName[$0] }
        let subModuleResults = foundModules.map { recursivelyFlattenProviders(in: $0, modulesByName: modulesByName, seenModules: &seenModules) }
        let subModuleProviders = subModuleResults.flatMap { $0.providers }
        let subModuleComponents = subModuleResults.flatMap { $0.subcomponents }
        let subModuleDiagnostics = subModuleResults.flatMap { $0.diagnostics }
        return ModuleSearchResult(
            providers: module.providers + subModuleProviders,
            subcomponents: module.subcomponents + subModuleComponents,
            diagnostics: diagnostics + subModuleDiagnostics
        )
    }
}

extension Resolver {
    fileprivate struct ComponentSearchResult {
        let component: ResolvedComponent
        let providersByType: [String:StandardProvider]
        let diagnostics: [ResolutionError]
    }
    
    fileprivate struct ModuleSearchResult {
        let providers: [StandardProvider]
        let subcomponents: [String]
        let diagnostics: [ResolutionError]
        
        static var empty: ModuleSearchResult {
            ModuleSearchResult(providers: [], subcomponents: [], diagnostics: [])
        }
    }
}

extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
