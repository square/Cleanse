//
//  BaseComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/5/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public protocol _AnyBaseComponent : Module {
    static var _internalRootType: Any.Type { get }
}

/// Base protocol for both Components and Subcomponenents

public protocol _BaseComponent : _AnyBaseComponent {
    /// This should be set to the root type of object that is created.
    associatedtype Root

}
