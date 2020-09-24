//
//  BindingsVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser
import os.log

struct BindingsResult {
    let standardProviders: [StandardProvider]
    let includedModules: [String]
    let installedSubcomponents: [String]
}

/**
 Traverses the tree within a body where bindings can be created. Often within the `configure` or `configureRoot` methods.
 
 Collects and finds all the provider types, included modules, and subcomponents that can be grouped by a parent.
 */
struct BindingsVisitor: SyntaxVisitor {
    private var standardProviders: [StandardProvider] = []
    private var includedModules: [String] = []
    private var installedSubcomponents: [String] = []
    
    fileprivate enum BindingAPI: String {
        case moduleInclude = "extension.include(module:)"
        case installComponent = "extension.install(dependency:)"
    }
    
    public mutating func visitChildren(node: FuncDecl) -> Bool {
        if node.raw.contains("configureRoot(binder:)") {
            return false
        } else {
            return true
        }
    }
    
    mutating func visit(node: CallExpr) {
        if node.isCleanseBinding {
            var bindingVisitor = ProviderVisitor()
            bindingVisitor.walk(node)
            guard let provider = bindingVisitor.finalize() else {
                os_log("Found binding expression, but failed to create any semblance of a provider. %@", type: .debug, node.raw)
                return
            }
            
            standardProviders.append(provider)
        }
    }
    
    mutating func visit(node: DeclrefExpr) {
        if node.raw.contains(BindingAPI.moduleInclude.rawValue) {
            if let moduleName = node.raw.firstCapture(#"substitution\sM\s->\s(.*)\)\)]"#) {
                includedModules.append(moduleName)
            } else {
                os_log("Found included module, but could not parse its name. %@", type: .debug, node.raw)
            }
        } else if node.raw.contains(BindingAPI.installComponent.rawValue) {
            if let subcomponentName = node.raw.firstCapture(#"substitution\sC\s->\s(.*)\)\)]"#) {
                installedSubcomponents.append(subcomponentName)
            } else {
                os_log("Found installed subcomponent, but could not parse its name. %@", type: .debug, node.raw)
            }
        }
    }
    
    func finalize() -> BindingsResult {
        BindingsResult(
            standardProviders: standardProviders,
            includedModules: includedModules,
            installedSubcomponents: installedSubcomponents
        )
    }
}
