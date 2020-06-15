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
    let danglingProviders: [DanglingProvider]
    let referenceProviders: [ReferenceProvider]
    let includedModules: [String]
    let installedSubcomponents: [String]
}

/**
 Traverses the tree within a body where bindings can be created. Often within the `configure` or `configureRoot` methods.
 
 Collects and finds all the provider types, included modules, and subcomponents that can be grouped by a parent.
 */
struct BindingsVisitor: SyntaxVisitor {
    private var standardProviders: [StandardProvider] = []
    private var danglingProviders: [DanglingProvider] = []
    private var referenceProviders: [ReferenceProvider] = []
    private var includedModules: [String] = []
    private var installedSubcomponents: [String] = []
    
    fileprivate enum BindingAPI: String {
        case moduleInclude = "extension.include(module:)"
        case installComponent = "extension.install(dependency:)"
    }
    
    mutating func visit(node: CallExpr) {
        if let type = node.type.firstCapture("BindingReceipt<(.*)>") {
            var bindingVisitor = ProviderVisitor(type: type)
            bindingVisitor.walk(node)
            guard let providerResult = bindingVisitor.finalize() else {
                os_log("Found binding expression, but failed to create any semblance of a provider. %@", type: .debug, node.raw)
                return
            }
            
            switch providerResult {
            case .provider(let provider):
                standardProviders.append(provider)
            case .danglingProviderBuilder(var danglingProviderBuilder):
                var danglingVisitor = DanglingProviderVisitor(type: danglingProviderBuilder.type)
                danglingVisitor.walk(node)
                guard let foundReference = danglingVisitor.finalize() else {
                    os_log("Unknown dangling reference provider type %@", type: .debug, node.raw)
                    return
                }
                danglingProviderBuilder = danglingProviderBuilder.setReference(foundReference)
                danglingProviders.append(danglingProviderBuilder.build())
            case .referenceBuilder(var referenceProviderBuilder):
                var referenceVisitor = ReferenceProviderVisitor(type: referenceProviderBuilder.type)
                referenceVisitor.walkChildren(node)
                switch referenceVisitor.finalize() {
                case .unknown:
                    os_log("Failed to parse reference node: %@", type: .debug, node.raw)
                    return
                case .dependencies(let dependencies):
                    referenceProviderBuilder = referenceProviderBuilder.setDependencies(dependencies: dependencies)
                case .reference(let reference):
                    referenceProviderBuilder = referenceProviderBuilder.setReference(reference: reference)
                }
                switch referenceProviderBuilder.build() {
                case .standard(let standardProvider):
                    standardProviders.append(standardProvider)
                case .reference(let referenceProvider):
                    referenceProviders.append(referenceProvider)
                }
            }
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
            danglingProviders: danglingProviders,
            referenceProviders: referenceProviders,
            includedModules: includedModules,
            installedSubcomponents: installedSubcomponents
        )
    }
}
