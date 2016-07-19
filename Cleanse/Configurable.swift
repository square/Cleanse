//
//  Configurable.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Base protocol for Components and Models. It allows for shared installation, but disambguates function call
public protocol Configurable {
    static func configure<B: Binder>(binder binder: B)
}
