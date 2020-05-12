//
//  ProviderVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

enum ProviderResult {
    case provider(StandardProvider)
    case danglingProviderBuilder(DanglingProviderBuilder)
    case referenceBuilder(ReferenceProviderBuilder)
}


/**
 Parses an individual binding to discern its provider type, dependencies, and any decorated types (i.e Tagged, Scoped, Factory).
 */
struct ProviderVisitor: SyntaxVisitor {
    private var binding: BindingType = .unknown
    private var dependencies: [String] = []
    private var bindingTypeBuilder = BaseBindingTypeBuilder.instance
    
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    // We just want to visit the first declrefExpr to discern the API used.
    mutating func visit(node: DeclrefExpr) {
        guard binding == .unknown else {
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
            dependencies = node.raw.allCaptures(#"substitution\sP_[\d]\s->\s(\S*)\)"#)
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
        if node.type.matches("BindingReceipt<.*>") {
            return
        }
        
        guard let firstType = node.type.allCaptures(#"(\w+)(?=<)"#).first,
            let baseBindingType = BaseBindingType(rawValue: firstType) else {
            return
        }
        switch baseBindingType {
        case .provider, .propertyInjector, .assistedInjectionProvider:
            bindingTypeBuilder = bindingTypeBuilder.setBaseGraphBinding()
        case .singularCollectionProvider:
            bindingTypeBuilder = bindingTypeBuilder.setCollectionBinding(singular: true)
        case .collectionProvider:
            bindingTypeBuilder = bindingTypeBuilder.setCollectionBinding(singular: false)
        case .taggedProvider:
            if let tag = node.type.allCaptures(#"(\w+(?:\.\w+)*)(?=>)"#).last {
                bindingTypeBuilder = bindingTypeBuilder.setTaggedBinding(tag: tag)
            } else {
                print("Found tagged provider, but failed to parse Tag")
            }
        case .scopedProvider:
            if let scope = node.type.allCaptures(#"(\w+)(?=>)"#).last {
                bindingTypeBuilder = bindingTypeBuilder.setScopedBinding(scope: scope)
            } else {
                print("Found scoped provider, but failed to parse scope")
            }
        }
    }
    
    func finalize() -> ProviderResult? {
        bindingTypeBuilder.build(bindingType: binding, type: type, dependencies: dependencies)
    }
}


fileprivate struct BaseBindingTypeBuilder {
    let graphBinding: Bool
    let collectionBinding: Bool
    let singularCollectionBinding: Bool
    let taggedBinding: String?
    let scopedBinding: String?
    
    static var instance: BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            graphBinding: false,
            collectionBinding: false,
            singularCollectionBinding: false,
            taggedBinding: nil,
            scopedBinding: nil
        )
    }
    
    func setBaseGraphBinding() -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            graphBinding: true,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: taggedBinding,
            scopedBinding: scopedBinding
        )
    }
    
    func setCollectionBinding(singular: Bool) -> BaseBindingTypeBuilder {
        if singular {
            return BaseBindingTypeBuilder(
                graphBinding: graphBinding,
                collectionBinding: collectionBinding,
                singularCollectionBinding: true,
                taggedBinding: taggedBinding,
                scopedBinding: scopedBinding
            )
        } else {
            return BaseBindingTypeBuilder(
                graphBinding: graphBinding,
                collectionBinding: true,
                singularCollectionBinding: singularCollectionBinding,
                taggedBinding: taggedBinding,
                scopedBinding: scopedBinding
            )
        }
    }
    
    func setTaggedBinding(tag: String) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            graphBinding: graphBinding,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: tag,
            scopedBinding: scopedBinding
        )
    }
    
    func setScopedBinding(scope: String) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            graphBinding: graphBinding,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: taggedBinding,
            scopedBinding: scope
        )
    }
    
    func build(bindingType: ProviderVisitor.BindingType, type: String, dependencies: [String]) -> ProviderResult? {
        let collectionType = (singularCollectionBinding || collectionBinding) ? (singularCollectionBinding ? "[\(type)]" : type) : nil
        switch bindingType {
        case .provider:
            // If bound into graph, full standard. Otherwise it's a dangling reference.
            if graphBinding {
                return .provider(StandardProvider(
                    type: type,
                    dependencies: dependencies,
                    tag: taggedBinding,
                    scoped: scopedBinding,
                    collectionType: collectionType)
                )
            } else {
                return .danglingProviderBuilder(DanglingProviderBuilder(
                    type: type,
                    dependencies: dependencies,
                    reference: nil)
                )
            }
        case .reference:
            return .referenceBuilder(ReferenceProviderBuilder(
                type: type,
                tag: taggedBinding,
                scope: scopedBinding,
                collectionType: collectionType,
                dependencies: nil,
                reference: nil)
            )
        case .unknown:
            return nil
        }
    }
}

extension ProviderVisitor {
    fileprivate enum Binding {
        case provider
        case taggedProvider(tag: String)
        case scopedProvider(scope: String)
        case collectionProvider(isSingular: Bool)
    }
    
    fileprivate enum BindingType {
        case unknown
        case reference
        case provider
    }
    
    fileprivate enum BaseBindingType: String, CaseIterable {
        case provider = "BaseBindingBuilder"
        case taggedProvider = "TaggedBindingBuilderDecorator"
        case scopedProvider = "ScopedBindingDecorator"
        case propertyInjector = "PropertyInjectorBindingBuilder"
        case assistedInjectionProvider = "AssistedInjectionSeedDecorator"
        case singularCollectionProvider = "SingularCollectionBindingBuilderDecorator"
        case collectionProvider = "CollectionBindingBuilderDecorator"
    }
    
    fileprivate enum BindingAPI: String, CaseIterable {
        case toValue = "decl=Cleanse.(file).BindToable extension.to(value:file:line:function:)"
        case toFactory = "decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:)"
        case configure = "decl=Cleanse.(file).BindToable extension.configured(with:)"
        case toFactoryPropertyInjector = "decl=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:)"
        case configurePropertyInjector = "decl=Cleanse.(file).BindToable extension.propertyInjector(configuredWith:)"
        case toFactoryAssistedInjection = "decl=Cleanse.(file).AssistedInjectionBuilder extension.to(file:line:function:factory:)"
    }
}
