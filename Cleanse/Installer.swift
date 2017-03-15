//
//  Installer.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// The portion of the `Binder` Protocol that is responsible for installing module dependencies
public protocol Installer {
    /**
     Installs a module as a dependnecy of the caller
     
     - parameter module: Module to install as a dependency of the caller (usually a `Module` or `RootComponent`).
     */
    func include<M: Module>(module: M.Type) where M.Scope == Unscoped

    func install<C: Component>(dependency: C.Type)
    func install<C: RootComponent>(dependency: C.Type)
}

