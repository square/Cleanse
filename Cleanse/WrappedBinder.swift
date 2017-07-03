//
//  WrappedBinder.swift
//  Cleanse
//
//  Created by Mike Lewis on 3/14/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

/// Makes it easy to wrap binders w/ each other
public protocol WrappedBinder : BinderBase {
    var binder: BinderBase { get }
    init(binder: BinderBase)
}


extension WrappedBinder {
    public func _internalBind(binding: RawProviderBinding) {
        binder._internalBind(binding: binding)
    }

    public func include<M : Module>(module: M.Type) where M.Scope == Unscoped {
        return binder.include(module: module)
    }

    public func install<C : Component>(dependency: C.Type) {
        return binder.install(dependency: dependency)
    }

    public func install<C : RootComponent>(dependency: C.Type) {
        return binder.install(dependency: dependency)
    }

    public func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        return binder._internalProvider(type, debugInfo: debugInfo)
    }
}
