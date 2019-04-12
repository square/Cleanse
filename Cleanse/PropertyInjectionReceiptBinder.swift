//
//  PropertyInjectionReceiptBinder.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

public struct PropertyInjectionReceiptBinder<E: AnyObject> : PropertyInjectorBindingBuilderProtocol {
    public typealias Element = E
    public typealias B = AnyBinder

    public let binder: AnyBinder

    init<BB: PropertyInjectorBindingBuilderProtocol>(_ underlyingBindingBuilder: BB) where BB.Element == Element {
        self.binder = AnyBinder(binder: underlyingBindingBuilder.binder)
    }

    public func toPropertyInjectorBindingBuilder() -> PropertyInjectorBindingBuilder<B, Element> {
        return PropertyInjectorBindingBuilder(binder: binder)
    }
}

public extension BindToable where Input: PropertyInjectorProtocol {
    func propertyInjector(configuredWith configurationFunction: (PropertyInjectionReceiptBinder<Input.Element>) -> BindingReceipt<PropertyInjector<Input.Element>>) -> BindingReceipt<PropertyInjector<Input.Element>> {
        return configurationFunction(PropertyInjectionReceiptBinder(PropertyInjectorBindingBuilder(binder: self.binder)))
    }
}
