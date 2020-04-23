//
//  ModuleVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

struct ConfigureVisitor: SyntaxVisitor {
    var providers: [Provider] = []
    var danglingProviders: [DanglingProvider] = []
    var includedModules: [String] = []
    var subcomponents: [String] = []
    
    private enum BindingAPI: String {
        case moduleInclude = "decl=Cleanse.(file).WrappedBinder extension.include(module:)"
        case installComponent = "Cleanse.(file).WrappedBinder extension.install(dependency:)"
    }
    
    mutating func visit(node: CallExpr) {
        if let type = node.type.firstCapture(pattern: "BindingReceipt<(.*)>") {
            var bindingVisitor = BindingVisitor(type: type)
            bindingVisitor.walk(node)
            switch bindingVisitor.binding {
            case .provider:
                var innerType: String? = nil
                var innerTag: String? = nil
                var innerScope: String? = nil
                bindingVisitor.bindings.forEach { b in
                    switch b {
                    case .provider:
                        innerType = type
                    case .taggedProvider(let tag):
                        innerTag = tag
                    case .scopedProvider(let scope):
                        innerScope = scope
                    }
                }
                
                if let finalType = innerType {
                    providers.append(Provider(
                        type: finalType,
                        dependencies: bindingVisitor.dependencies,
                        tag: innerTag,
                        scoped: innerScope)
                    )
                } else {
                    // Dangling
                    danglingProviders.append(DanglingProvider(
                        type: type,
                        dependencies: bindingVisitor.dependencies)
                    )
                }
            case .reference:
                // TODO
                break
            case .unknown:
                print("Found binding expression, but failed to create any semblance of a provider. \(node.raw)")
            }
        }
    }
    
    mutating func visit(node: DeclrefExpr) {
        if node.raw.contains(BindingAPI.moduleInclude.rawValue) {
            if let moduleName = node.raw.firstCapture(pattern: #"substitution\sM\s->\s(\w+)\)"#) {
                includedModules.append(moduleName)
            } else {
                print("Found module, but could not parse its name.")
            }
        } else if node.raw.contains(BindingAPI.installComponent.rawValue) {
            if let subcomponentName = node.raw.firstCapture(pattern: #"substitution\sC\s->\s(\w+)\)"#) {
                subcomponents.append(subcomponentName)
            } else {
                print("Found subcomponent, but could not parse its name.")
            }
        }
    }
}

