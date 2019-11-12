//
//  SPI.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 10/9/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

/**
 Plugin hook that gives conforming objects read-only access to the Cleanse object graph.
 
 In order for your plugin to be run, it must registered with an instance of a `CleanseServiceLoader` and passed into
 the `ComponentFactory.of(_:validate:serviceLoader:)` function. Plugins will only be run if the `validate` param is `true`.
**/

public protocol CleanseBindingPlugin {
    /// Plugin entry point function that is called by the service loader.
    ///
    /// - Parameter root: Root component of the object graph.
    /// - Parameter errorReporter: Reporter used to append errors that are used to fail validation.
    ///
    func visit(root: ComponentBinding, errorReporter: CleanseErrorReporter)
}
