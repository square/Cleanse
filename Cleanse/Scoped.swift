//
//  Scoped.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// A type may conform to scoped. This is equivalent to doing `scoped(in: Scope)` when creating a binding
public protocol Scoped {
    associatedtype Scope : Cleanse.Scope
}

