//
//  ComposedComponentExtension.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public extension OverrideModule {
    
    // NOTE: this doesn't seem to work in Swift3
    
    #if false
    
    public typealias ComposedComponent = OverriddenComponent<Self.Overrides, Self>
    
    #endif
}