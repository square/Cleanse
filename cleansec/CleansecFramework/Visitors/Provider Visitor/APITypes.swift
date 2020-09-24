//
//  APITypes.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 9/24/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

enum BaseBindingType: String, CaseIterable {
    case provider = "BaseBindingBuilder"
    case taggedProvider = "TaggedBindingBuilderDecorator"
    case scopedProvider = "ScopedBindingDecorator"
    case propertyInjector = "PropertyInjectorBindingBuilder"
    case assistedInjectionProvider = "AssistedInjectionSeedDecorator"
    case singularCollectionProvider = "SingularCollectionBindingBuilderDecorator"
    case collectionProvider = "CollectionBindingBuilderDecorator"
}

enum BindingAPI: String, CaseIterable {
    case toValue = "decl=Cleanse.(file).BindToable extension.to(value:file:line:function:)"
    case toFactory = "decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:)"
    case toFactoryPropertyInjector = "decl=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:)"
    case toFactoryAssistedInjection = "decl=Cleanse.(file).AssistedInjectionBuilder extension.to(file:line:function:factory:)"
}


extension CallExpr {
    var isCleanseBinding: Bool {
        return type.firstCapture("BindingReceipt<(.*)>") != nil
    }
}
