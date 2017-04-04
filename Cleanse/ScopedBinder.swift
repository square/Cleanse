//
//  Binder.swift
//  Cleanse
//
//  Created by Mike Lewis on 3/14/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation


/// This is a Binder that is Scope aware
public protocol BinderType : BinderBase {
    associatedtype Scope: Cleanse._ScopeBase
}

public struct Binder<S: Cleanse._ScopeBase> : BinderType, WrappedBinder {
    public let binder: BinderBase

    public init(binder: BinderBase) {
        // Optimization to reduce nesting of wrapped binders
        if let binder = binder as? WrappedBinder {
            self.binder = binder.binder
        } else {
            self.binder = binder
        }
    }

    public typealias Scope = S
}

extension BinderType {
    /// For including scoped modules
    public func include<M : Module>(module: M.Type) where M.Scope == Self.Scope, M.Scope: Cleanse.Scope {
        return include(module: AnyScopedModule<M>.self)
    }
}

/// Used for making a module looks unscoped. This is so we can disambiguate includes
private struct AnyScopedModule<M: Module> : Module {
    typealias Scope = Unscoped
    
    fileprivate static func configure(binder: UnscopedBinder) {
        M.configure(binder: .init(binder: binder))
    }
}

/// Default binder used
public typealias UnscopedBinder = Binder<Unscoped>
