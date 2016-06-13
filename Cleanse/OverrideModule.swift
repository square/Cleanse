//
//  OverrideComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/**
 An override module overrides functionality in the `Overrides` component defined by the implementor. It is required to have 0-arguments as a constructor
 
 `OverrideModule` functionality should only be used in Tests or "Debug" mode.
 
 
 - Note: `Override` APIs are experimental at best, and may just go away. Please don't depend on it too much. They are somewhat of a leaky abstraction, but make testing a lot easier
 
 */
public protocol OverrideModule : Module {
    /// This is the component that we override
    associatedtype Overrides: Component
    
    /// `OverrideModule`s need to be constructed without arguments to make valdiation easy. Since they
    init()
}