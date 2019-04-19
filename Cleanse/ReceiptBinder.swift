//
//  ReceiptBinder.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation


public struct ReceiptBinder<Element> : BindToable {
    public typealias Input = Element
    public typealias Binder = AnyBinder

    private let innerTo: (_ file: StaticString, _ line: Int, _ function: StaticString, _ provider: Provider<Input>) -> BindingReceipt<Input>
    public let binder: AnyBinder

    public let _finalProviderType : Any.Type


    init<BB: BindToable>(_ underlyingBindingBuilder: BB) where BB.Input == Input {
        self.innerTo = underlyingBindingBuilder._innerTo
        self.binder = AnyBinder(binder: underlyingBindingBuilder.binder)
        self._finalProviderType = underlyingBindingBuilder._finalProviderType
    }

    public func _innerTo(file: StaticString, line: Int, function: StaticString, provider: Provider<Input>) -> BindingReceipt<Input> {
        return innerTo(file, line, function, provider)
    }
}

public extension BindToable {
    @discardableResult
    func configured(with configurationFunction: (ReceiptBinder<Input>) -> BindingReceipt<Input>) -> BindingReceipt<Input> {
        return configurationFunction(ReceiptBinder(self))
    }
}

//public extension BindToable where 
