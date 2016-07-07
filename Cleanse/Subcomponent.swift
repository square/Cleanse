//
//  Subcomponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol Subcomponent : _BaseComponent {
    /// This is the binding required to construct a new subcomponent
    associatedtype Seed = Void

    /// Subcomponents can have custom scopes associated with them.
    associatedtype Scope = _Unscoped
}