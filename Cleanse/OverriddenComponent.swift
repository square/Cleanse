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
    
    public static func configure<B : Binder>(binder binder: B) {
        C.configure(binder: binder)
        
        binder._internalWithOverrides {
            Overrides.configure(binder: binder)
        }
    }
}
