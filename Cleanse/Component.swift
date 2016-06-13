//
//  Component.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Used to detect if things being bound are a component.
/// Un-typed base protocol of component. Probably shouldn't be used directly
public protocol _AnyComponent : _AnyBaseComponent {
}

public protocol Component : Module, _BaseComponent, _AnyComponent {
    /// This should be set to the root type of object that is created.
    associatedtype Root
}

public extension Component {
    /// Builds the component and returns the root object.
    /// - throws: `CleanseError` if the component fails validation.
    public func build() throws -> Root {
        let graph = Graph()
        
        let p = graph.provider(Root.self)

        graph.install(module: self)

        try graph.finalize()
        
        return p.get()
    }
}



public extension Component {
    /// Default implementation. Helps with type-erasure
    public static var _internalRootType: Any.Type {
        return Root.self
    }
}
