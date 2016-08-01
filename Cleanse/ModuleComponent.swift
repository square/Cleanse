//
//  ModuleComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Simple component to make testing easy. Probably should not use this in a standard app.
public struct ModuleComponent<M: Module, RO> : RootComponent {
    public typealias Root = RO
    
    public static func configure<B: Binder>(binder binder: B) {
        binder.install(module: M.self)
    }
}

public extension Module {
    /// Convenience method. Probably shouldn't use outside of tests. THis converts a module into a component that has the `Root` of `rootObjectType`
    public static func asComponent<RO>(rootObjectType rootObjectType: RO.Type) -> ModuleComponent<Self, RO>.Type {
        return ModuleComponent.self
    }
    
    /// Convenience method for testing. Turns a Module into a PropertyInjector for Element
    public static func asPropertyInjectorComponent<Element: AnyObject>(targetClass targetClass: Element.Type) -> ModuleComponent<Self, PropertyInjector<Element>>.Type {
        return ModuleComponent.self
    }
}
