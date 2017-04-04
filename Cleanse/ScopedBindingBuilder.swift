//
//  ScopedBindingBuilder.swift
//  Cleanse
//
//  Created by Mike Lewis on 3/14/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

extension BindingBuilder where Binder: BinderType, MaybeScope == Unscoped, Binder.Scope: Scope {
    // Declares binding as scoped. Also known as singletons in some contexts
    public func sharedInScope() -> ScopedBindingDecorator<Self, Binder.Scope> {
        return self.with()
    }
}
