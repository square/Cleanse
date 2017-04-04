//
//  AnyBinder.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

/// Type erased binder
public struct AnyBinder : BinderBase, WrappedBinder {
    public let binder: BinderBase

    public init(binder: BinderBase) {
        // Optimization to reduce nesting of wrapped binders
        if let binder = binder as? WrappedBinder {
            self.binder = binder.binder
        } else {
            self.binder = binder
        }
    }
}
