//
//  BaseComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/5/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public protocol _AnyBaseComponent : Configurable {
}

/// Base protocol for both Components and Subcomponenents
public protocol _BaseComponent : _AnyBaseComponent {
    /// This is the binding required to construct a new Component. Think of it as somewhat of an initialization value.
    associatedtype Seed = Void

    /// This should be set to the root type of object that is created.
    associatedtype Root

    associatedtype Scope: Cleanse.Scope

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root>
}
