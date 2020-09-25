//
//  ProviderVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser
import os.log

/**
 Parses an individual binding to discern its provider type, dependencies, and any decorated types (i.e Tagged, Scoped, Factory).
 */
public struct ProviderVisitor: SyntaxVisitor {
    private var binding: BindingType = .unknown
    private var dependencies: [String] = []
    private var bindingTypeBuilder = BaseBindingTypeBuilder.instance
    
    // We just want to visit the first declrefExpr to discern the API used.
    public mutating func visit(node: DeclrefExpr) {
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
            dependencies = node.raw.allCaptures(#"\(substitution\sP_[\d]+\s->\s(\(\).*?|.*?)(?=\)\s|\)\)])"#)
            binding = .provider
        }
    }
    
    public mutating func visit(node: CallExpr) {
        if let _ = node.type.firstCapture("BindingReceipt<(.*)>") {
            if let loc = node.raw.firstCapture(#"location=(.*)\srange"#) {
                bindingTypeBuilder = bindingTypeBuilder.setDebugData(.location(loc))
            }
            return
        }
        
        guard let firstType = node.type.allCaptures(#"(\w+)(?=<)"#).first,
            let baseBindingType = BaseBindingType(rawValue: firstType) else {
            return
        }
        switch baseBindingType {
        case .provider:
            if let type = node.type.firstCapture(#"BaseBindingBuilder<(.*),\s.*>"#) {
                bindingTypeBuilder = bindingTypeBuilder.setBaseGraphBinding(type: type)
            } else {
                os_log("Found base binding but couldn't parse type for: %@", type: .debug, node.raw)
            }
        case .propertyInjector:
            if let type = node.type.firstCapture(#"PropertyInjectorBindingBuilder<.*,\s(.*)(?>)>"#) {
                bindingTypeBuilder = bindingTypeBuilder.setBaseGraphBinding(type: "PropertyInjector<\(type)>")
            } else {
                os_log("Found base binding but couldn't parse type for: %@", type: .debug, node.raw)
            }
        case .assistedInjectionProvider:
            if let type = node.type.firstCapture(#"AssistedInjectionSeedDecorator<.*,\s(.*)(?>)>"#) {
                bindingTypeBuilder = bindingTypeBuilder.setBaseGraphBinding(type: "Factory<\(type)>")
            } else {
                os_log("Found base binding but couldn't parse type for: %@", type: .debug, node.raw)
            }
        case .singularCollectionProvider:
            bindingTypeBuilder = bindingTypeBuilder.setCollectionBinding(singular: true)
        case .collectionProvider:
            bindingTypeBuilder = bindingTypeBuilder.setCollectionBinding(singular: false)
        case .taggedProvider:
            if let tag = node.type.allCaptures(#"(\w+(?:\.\w+)*)(?=>)"#).last {
                bindingTypeBuilder = bindingTypeBuilder.setTaggedBinding(tag: tag)
            } else {
                os_log("Found tagged provider, but failed to parse Tag", type: .debug)
            }
        case .scopedProvider:
            if let scope = node.type.firstCapture(#"ScopedBindingDecorator.*\sBinder<(.*)>(?=\.Scope)"#) {
                bindingTypeBuilder = bindingTypeBuilder.setScopedBinding(scope: scope)
            } else {
                os_log("Found scoped provider, but failed to parse scope", type: .debug)
            }
        }
    }
    
    public func finalize() -> StandardProvider? {
        bindingTypeBuilder.build(bindingType: binding, dependencies: dependencies)
    }
}


fileprivate struct BaseBindingTypeBuilder {
    let type: String?
    let graphBinding: Bool
    let collectionBinding: Bool
    let singularCollectionBinding: Bool
    let taggedBinding: String?
    let scopedBinding: String?
    let debugData: DebugData
    
    static var instance: BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            type: nil,
            graphBinding: false,
            collectionBinding: false,
            singularCollectionBinding: false,
            taggedBinding: nil,
            scopedBinding: nil,
            debugData: .empty
        )
    }
    
    func setDebugData(_ data: DebugData) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            type: type,
            graphBinding: graphBinding,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: taggedBinding,
            scopedBinding: scopedBinding,
            debugData: data
        )
    }
    
    func setBaseGraphBinding(type: String) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            type: type,
            graphBinding: true,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: taggedBinding,
            scopedBinding: scopedBinding,
            debugData: debugData
        )
    }
    
    func setCollectionBinding(singular: Bool) -> BaseBindingTypeBuilder {
        if singular {
            return BaseBindingTypeBuilder(
                type: type,
                graphBinding: graphBinding,
                collectionBinding: collectionBinding,
                singularCollectionBinding: true,
                taggedBinding: taggedBinding,
                scopedBinding: scopedBinding,
                debugData: debugData
            )
        } else {
            return BaseBindingTypeBuilder(
                type: type,
                graphBinding: graphBinding,
                collectionBinding: true,
                singularCollectionBinding: singularCollectionBinding,
                taggedBinding: taggedBinding,
                scopedBinding: scopedBinding,
                debugData: debugData
            )
        }
    }
    
    func setTaggedBinding(tag: String) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            type: type,
            graphBinding: graphBinding,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: tag,
            scopedBinding: scopedBinding,
            debugData: debugData
        )
    }
    
    func setScopedBinding(scope: String) -> BaseBindingTypeBuilder {
        return BaseBindingTypeBuilder(
            type: type,
            graphBinding: graphBinding,
            collectionBinding: collectionBinding,
            singularCollectionBinding: singularCollectionBinding,
            taggedBinding: taggedBinding,
            scopedBinding: scope,
            debugData: debugData
        )
    }
    
    func build(bindingType: BindingType, dependencies: [String]) -> StandardProvider? {
        guard let type = type else {
            return nil
        }
        var collectionType: String? = nil
        if collectionBinding {
            if type.matches(#"[.*]"#) {
                collectionType = type
            } else {
                collectionType = "[\(type)]"
            }
        } else if singularCollectionBinding {
            collectionType = "[\(type)]"
        }
        switch bindingType {
        case .provider:
            return StandardProvider(
                type: type,
                dependencies: dependencies,
                tag: taggedBinding,
                scoped: scopedBinding,
                collectionType: collectionType,
                debugData: debugData
            )
        case .unknown:
            return nil
        }
    }
}

fileprivate enum Binding {
    case provider
    case taggedProvider(tag: String)
    case scopedProvider(scope: String)
    case collectionProvider(isSingular: Bool)
}

fileprivate enum BindingType {
    case unknown
    case provider
}
