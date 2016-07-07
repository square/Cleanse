//
//  Scoped.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Type-erased version of scoped. For internal use only
public protocol _AnyScoped {
    static var _scopeType: Cleanse.Scope.Type { get }
}

/// A type may conform to scoped. This is equivalent to doing `scoped(in: Scope)` when creating a binding
public protocol Scoped : _AnyScoped {
    associatedtype Scope : Cleanse.Scope
}

extension Scoped {
    public static var _scopeType: Cleanse.Scope.Type {
        return Scope.self
    }
}