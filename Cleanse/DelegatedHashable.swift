//
//  DelegatedHashable.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/22/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Easy way to make a hashable object. Delegates it to a hashable property.
public protocol DelegatedHashable : Hashable {
    associatedtype H: Hashable
    var hashable: H { get }
}

extension DelegatedHashable {    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(hashable)
    }
}

public func ==<DH: DelegatedHashable>(lhs: DH, rhs: DH) -> Bool {
    return lhs.hashable == rhs.hashable
}

