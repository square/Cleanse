//
//  Component.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol Component : _BaseComponent {
    ///  can have custom scopes associated with them.
    associatedtype Scope = _Unscoped
}
