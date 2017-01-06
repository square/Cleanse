//
//  AnyBinder.swift
//  Cleanse
//
//  Created by Mike Lewis on 1/6/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation

/// Type erased binder
public class AnyBinder : Binder {
    private let internalBind : (RawProviderBinding) -> ()

    private let underlying: protocol<Installer, ProviderProvider>

    init<B: Binder>(binder: B) {
        self.internalBind = binder._internalBind
        self.underlying = binder
    }

    public func _internalBind(binding binding: RawProviderBinding) {
        self.internalBind(binding)
    }

    public func include<M : Module>(module module: M.Type) {
        return underlying.include(module: module)
    }

    public func install<C : Component>(dependency dependency: C.Type) {
        return underlying.install(dependency: dependency)
    }

    public func _internalProvider<Element>(type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element> {
        return underlying._internalProvider(type, debugInfo: debugInfo)
    }
}
