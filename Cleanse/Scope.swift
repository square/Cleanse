//
//  Scope.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

// Type erased version of Scope

/// Currently there are only two scopes, `_Unscoped` and `Singleton`.
public protocol Scope {
}

/// This a special scope that means its not scoped
public struct _Unscoped : Scope {
}

/// This is similar to the javax.inject.Singleton in java
public struct Singleton : Scope {
}
