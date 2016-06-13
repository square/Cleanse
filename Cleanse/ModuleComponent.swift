//
//  ModuleComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Simple component to make testing easy. Probably should not use this in a standard app.
public struct ModuleComponent<M: Module, RO> : Component {
    private let module: M
    
    public typealias Root = RO
    
    private init(module: M, rootObjectType: RO.Type) {
        self.module = module
    }
    
    public func configure<B: Binder>(binder binder: B) {
        binder.install(module: self.module)
    }
}

public extension Module {
    /// Convenience method. Probably shouldn't use outside of tests. THis converts a module into a component that has the `Root` of `rootObjectType`
    public func asComponent<RO>(rootObjectType rootObjectType: RO.Type) -> ModuleComponent<Self, RO> {
        return ModuleComponent(module: self, rootObjectType: rootObjectType)
    }
    
    /// Convenience method for testing. Turns a Module into a PropertyInjector for Element
    public func asPropertyInjectorComponent<Element: AnyObject>(targetClass targetClass: Element.Type) -> ModuleComponent<Self, PropertyInjector<Element>> {
        return asComponent(rootObjectType: PropertyInjector<Element>.self)
    }
    
    /// Convenience method. Probably shouldn't use outside of tests. This does the following:
    ///
    /// 1. Converts module into a component
    /// 2. Creates object graph and pulls out property injector.
    /// 3. Tries to inject properties into target instance.
    public func buildAsComponentAndInjectPropertiesInto<Element: AnyObject>(targetInstance targetInstance: Element) throws {
        try asPropertyInjectorComponent(targetClass: Element.self).build().injectProperties(into: targetInstance)
    }
    
    
    /// Convenience method. Probably shouldn't use outside of tests. This does the following:
    ///
    /// 1. Converts module into a component
    /// 2. Creates object graph and pulls out root element
    public func buildAsComponent<Element>(rootObjectType rootObjectType: Element.Type) throws -> Element {
        return try asComponent(rootObjectType: rootObjectType).build()
    }
}