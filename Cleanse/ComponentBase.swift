//
//  ComponentBase.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/5/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Base protocol for both Components and RootComponents. Generally want to implement Components or RootComponent instead
public protocol ComponentBase {
    /// This is the binding required to construct a new Component. Think of it as somewhat of an initialization value.
    associatedtype Seed = Void

    /// This should be set to the root type of object that is created.
    associatedtype Root

    associatedtype Scope: Cleanse._ScopeBase = Unscoped

    static func configure(binder: Binder<Self.Scope>)

    static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root>
}
