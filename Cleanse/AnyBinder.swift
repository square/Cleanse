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
    let binder: BinderBase
}
