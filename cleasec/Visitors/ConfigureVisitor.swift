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
    var providers: [StandardProvider] = []
    var danglingProviders: [DanglingProvider] = []
    var referenceProviders: [ReferenceProvider] = []
    var includedModules: [String] = []
    var subcomponents: [String] = []
    
    private enum BindingAPI: String {
        case moduleInclude = "extension.include(module:)"
        case installComponent = "extension.install(dependency:)"
    }
    
    mutating func visit(node: CallExpr) {
        if let type = node.type.firstCapture(pattern: "BindingReceipt<(.*)>") {
            var bindingVisitor = BindingVisitor(type: type)
            bindingVisitor.walk(node)
            
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
            
            switch bindingVisitor.binding {
            case .provider:
                if let finalType = innerType {
                    providers.append(StandardProvider(
                        type: finalType,
                        dependencies: bindingVisitor.dependencies,
                        tag: innerTag,
                        scoped: innerScope)
                    )
                } else {
                    var receiptBinderVisitor = ReceiptBinderVisitor(type: type)
                    receiptBinderVisitor.walk(node)
                    if let reference = receiptBinderVisitor.reference {
                        danglingProviders.append(DanglingProvider(
                            type: type,
                            dependencies: bindingVisitor.dependencies,
                            reference: reference)
                        )
                    } else {
                        print("Unknown dangling reference provider type.")
                    }
                    
                }
            case .reference:
                var referenceVisitor = ReferenceVisitor(type: type)
                referenceVisitor.walkChildren(node)
                switch referenceVisitor.referenceType {
                case .provider(let provider):
                    providers.append(StandardProvider(
                        type: provider.type,
                        dependencies: provider.dependencies,
                        tag: innerTag,
                        scoped: innerScope)
                    )
                case .reference(let reference):
                    referenceProviders.append(ReferenceProvider(
                        type: type,
                        tag: innerTag,
                        scoped: innerScope,
                        reference: reference)
                    )
                case .unknown:
                    print("Failed to parse reference node: \(node)")
                }
                
            case .unknown:
                print("Found binding expression, but failed to create any semblance of a provider. \(node.raw)")
            }
        }
    }
    
    mutating func visit(node: DeclrefExpr) {
        if node.raw.contains(BindingAPI.moduleInclude.rawValue) {
            if let moduleName = node.raw.firstCapture(pattern: #"substitution\sM\s->\s(.*)\)\)]"#) {
                includedModules.append(moduleName)
            } else {
                print("Found module, but could not parse its name. \(node)")
            }
        } else if node.raw.contains(BindingAPI.installComponent.rawValue) {
            if let subcomponentName = node.raw.firstCapture(pattern: #"substitution\sC\s->\s(.*)\)\)]"#) {
                subcomponents.append(subcomponentName)
            } else {
                print("Found subcomponent, but could not parse its name.")
            }
        }
    }
}

