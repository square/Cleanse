//
//  Installer.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// The portion of the `Binder` Protocol that is responsible for installing module dependencies
public protocol Installer : class {
    /**
     Installs a module as a dependnecy of the caller
     
     - parameter module: Module to install as a dependency of the caller (usually a `Module` or `Component`).
     */
    func install<M: Module>(module module: M)
    
    /// This is used internally to support override modules
    func _internalWithOverrides(@noescape closure closure: () -> ())
}