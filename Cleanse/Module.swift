//
//  Module.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/**
 Basic building block for an object graph or component. A module defines how instances are created that are exposed to the rest of the object graph as well as requirements to construct these provided instances.
 
 In the words of Guice documentation, _["Modules should be fast and side-effect free"](https://github.com/google/guice/wiki/ModulesShouldBeFastAndSideEffectFree)_.
 
 This is the same for modules in Cleanse, if not even moreso since "configure" may be called more than once to validate the object graph.
 */
public protocol Module : Configurable {
    /// This is where configuring providers occurs.
    static func configure<B: Binder>(binder: B) // Re-declared to provide more specific description
}

