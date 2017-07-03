//
//  ScopedBindingDecorator.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Internal type used for binding. We decorate a provider with this to indicate if we're scoped or not
public struct ScopedBindingDecorator<Wrapped: BindingBuilder, S: _ScopeBase> : BindingBuilderDecorator {
    public typealias MaybeScope = S

    public typealias FinalProvider = Wrapped.FinalProvider

    public let wrapped: Wrapped
    
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
}
