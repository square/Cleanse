//
//  Linker.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import os.log

/**
 Unified interface containing all modules, components, and providers.
 */
public struct Linker {
    /// Links all the reference providers to their dangling providers.
    ///
    /// - parameter modules: List of `ModuleRepresentation` instances to link all providers.
    /// - returns: `LinkedInterface` instance with all modules, components, and linked `StandardProvider` instances.
    ///
    public static func link(modules: [ModuleRepresentation]) -> LinkedInterface {
        let files = modules.flatMap { $0.files }
        return link(files: files)
    }
    
    private static func link(files: [FileRepresentation]) -> LinkedInterface {
        let components = files.flatMap { $0.components }
        let modules = files.flatMap { $0.modules }
        
        let linkedComponents = components.map { component -> LinkedComponent in
            return LinkedComponent(
                type: component.type,
                rootType: component.rootType,
                providers: component.providers,
                seed: component.seed,
                includedModules: component.includedModules,
                subcomponents: component.subcomponents,
                isRoot: component.isRoot
            )
        }
        
        let linkedModules = modules.map { module -> LinkedModule in
            return LinkedModule(
                type: module.type,
                providers: module.providers,
                includedModules: module.includedModules,
                subcomponents: module.subcomponents
            )
        }
        
        return LinkedInterface(
            components: linkedComponents,
            modules: linkedModules
        )
    }
}
