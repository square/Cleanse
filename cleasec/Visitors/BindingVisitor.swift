//
//  BindingVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser
 
struct BindingVisitor: SyntaxVisitor {
    enum Binding {
        case provider
        case taggedProvider(tag: String)
        case scopedProvider(scope: String)
    }
    
    enum BindingType {
        case unknown
        case reference
        case provider
    }
    private enum BaseBindingType: String, CaseIterable {
        case provider = "BaseBindingBuilder"
        case taggedProvider = "TaggedBindingBuilderDecorator"
        case scopedProvider = "ScopedBindingDecorator"
        case propertyInjector = "PropertyInjectorBindingBuilder"
        case assistedInjectionProvider = "AssistedInjectionSeedDecorator"
    }
    
    private enum BindingAPI: String, CaseIterable {
        case toValue = "decl=Cleanse.(file).BindToable extension.to(value:file:line:function:)"
        case toFactory = "decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:)"
        case configure = "decl=Cleanse.(file).BindToable extension.configured(with:)"
        case toFactoryPropertyInjector = "decl=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:)"
        case configurePropertyInjector = "decl=Cleanse.(file).BindToable extension.propertyInjector(configuredWith:)"
        case toFactoryAssistedInjection = "decl=Cleanse.(file).AssistedInjectionBuilder extension.to(file:line:function:factory:)"
    }
    
    let type: String
    var binding: BindingType = .unknown
    var dependencies: [String] = []
    var bindings: [Binding] = []
    
    mutating func visit(node: DeclrefExpr) {
        switch binding {
        case .unknown:
            break
        default:
            return
        }
        
        guard let api = BindingAPI.allCases.first(where: { (bindingApi) -> Bool in
            node.raw.contains(bindingApi.rawValue)
        }) else {
            return
        }
        
        switch api {
        case .toValue:
            binding = .provider
        case .toFactory, .toFactoryPropertyInjector, .toFactoryAssistedInjection:
            dependencies = node.raw.allCaptures(pattern: #"substitution\sP_[\d]\s->\s(\S*)\)"#)
            // Sanitizes trailing ')' character from regex pattern. Worth fixing the regex.
            if var last = dependencies.popLast() {
                last.removeLast()
                dependencies.append(last)
            }
            binding = .provider
        case .configure, .configurePropertyInjector:
            binding = .reference
        }
    }
    
    mutating func visit(node: CallExpr) {
        if node.type.contains(pattern: "BindingReceipt<.*>") {
            return
        }
        
        guard let firstType = node.type.allCaptures(pattern: #"(\w+)(?=<)"#).first, let baseBindingType = BaseBindingType(rawValue: firstType) else {
            return
        }
        switch baseBindingType {
        case .provider, .propertyInjector, .assistedInjectionProvider:
            bindings.append(.provider)
        case .taggedProvider:
            if let tag = node.type.allCaptures(pattern: #"(\w+)(?=>)"#).last {
                bindings.append(.taggedProvider(tag: tag))
            } else {
                print("Found tagged provider, but failed to parse Tag")
            }
        case .scopedProvider:
            if let scope = node.type.allCaptures(pattern: #"(\w+)(?=>)"#).last {
                bindings.append(.scopedProvider(scope: scope))
            } else {
                print("Found scoped provider, but failed to parse scope")
            }
        }
    }
}
