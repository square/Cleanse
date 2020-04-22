//
//  ModuleVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

struct ModuleVisitor: SyntaxVisitor {
    let name: String
    var providers: [Provider] = []
    
    mutating func visit(node: CallExpr) {
        if let type = node.type.firstCapture(pattern: "BindingReceipt<(.*)>") {
            var bindingVisitor = DeclVisitor(type: type)
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
                guard let finalType = innerType else {
                    print("Found type but couldn't discern BaseBindingBuilder")
                    return
                }
                providers.append(Provider(
                    type: finalType,
                    dependencies: bindingVisitor.dependencies,
                    tag: innerTag,
                    scoped: innerScope)
                )
            default:
                // TODO
                break
            }
        }
    }
}


fileprivate struct DeclVisitor: SyntaxVisitor {
    enum Binding {
        case provider
        case taggedProvider(tag: String)
        case scopedProvider(scope: String)
    }
    
    enum BindingType {
        case unknown
        case dangling
        case reference
        case provider
    }
    private enum BaseBindingType: String, CaseIterable {
        case provider = "BaseBindingBuilder"
        case taggedProvider = "TaggedBindingBuilderDecorator"
        case scopedProvider = "ScopedBindingDecorator"
    }
    
    private enum BindingAPI: String, CaseIterable {
        case toValue = "decl=Cleanse.(file).BindToable extension.to(value:file:line:function:)"
        case toFactory = "decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:)"
        case configure = "decl=Cleanse.(file).BindToable extension.configured(with:)"
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
        case .toFactory:
            dependencies = node.raw.allCaptures(pattern: #"substitution\sP_[\d]\s->\s(\w+)\)"#)
            binding = .provider
        case .configure:
            binding = .dangling
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
        case .provider:
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
