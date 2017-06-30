//
//  BindToable.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

public protocol BindToable {
    associatedtype Input
    associatedtype Binder : BinderBase

    func _innerTo(
        file: StaticString,
        line: Int,
        function: StaticString,
        provider: Provider<Input>) -> BindingReceipt<Input>

    var _finalProviderType: Any.Type { get }

    var binder: Binder { get }
}
