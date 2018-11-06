//
//  Scope.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

// Type erased version of Scope

public protocol _ScopeBase {
}


/// Currently there are only two scopes, `Unscoped` and `Singleton`.
public protocol Scope : _ScopeBase {
}


/// This a special scope that means its not scoped
public struct Unscoped : _ScopeBase {
}

extension _ScopeBase {

    // Returns our metatype if we're not `Unscoped`
    static var scopeOrNil: Scope.Type? {
        return self as? Scope.Type
    }
}
