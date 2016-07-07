//
//  OverriddenComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// Generic component that composes an existing component and an `OverrideModule` to make a new `RootComponent` with the same `Root` as the overridden one 
///
/// - Note: `Override` API is subject to change. Probably should not depend on this
public struct OverriddenComponent<C: RootComponent, Overrides : OverrideModule> : RootComponent, _BaseComponent {
    public typealias Root = C.Root
    
    let componentProvider: Provider<C>
    let overrides: Overrides
    
    private init(componentProvider: Provider<C>, overrides: Overrides) {
        self.componentProvider = componentProvider
        self.overrides = overrides
    }
    
    public func configure<B : Binder>(binder binder: B) {
        componentProvider.get().configure(binder: binder)
        
        binder._internalWithOverrides {
            overrides.configure(binder: binder)
        }
    }
}

extension RootComponent {
    /**
     This is to be used on the outer-most component when getting the root object
     
     - Note: `Override` APIs are experimental at best, and may just go away. Please don't depend on it too much. They are somewhat of a leaky abstraction, but make testing a lot easier
     */
    public func withOverrides<M: OverrideModule where M.Overrides == Self>(overrideModule overrideModule: M) -> OverriddenComponent<Self, M> {
        return OverriddenComponent(componentProvider: .init(value: self), overrides: overrideModule)
    }
    
    private static func withOverrides<M: OverrideModule where M.Overrides == Self>(overrideModule overrideModuleType: M.Type) -> Provider<Self> -> OverriddenComponent<Self, M> {
        return { $0.get().withOverrides(overrideModule: overrideModuleType.init()) }
    }
}