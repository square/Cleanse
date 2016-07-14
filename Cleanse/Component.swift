//
//  RootComponent.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Used to detect if things being bound are a component.
/// Un-typed base protocol of component. Probably shouldn't be used directly
public protocol _AnyRootComponent : _AnyBaseComponent {
}


/// RootComponent has been renamed to RootComponent
#if swift(>=3.0)
    @available(*, deprecated, renamed:"RootComponent")
    public typealias Component = RootComponent
#else
    @available(*, deprecated, renamed="RootComponent")
    public typealias Component = RootComponent
#endif

public protocol RootComponent : Module, _BaseComponent, _AnyRootComponent {
    /// This should be set to the root type of object that is created.
    associatedtype Root

    associatedtype Scope = Singleton
}

public extension RootComponent {
    /// Builds the component and returns the root object.
    /// - throws: `CleanseError` if the component fails validation.
    public func build() throws -> Root {
        let graph = Graph(scope: Self.Scope.scopeOrNil)
        
        let p = graph.provider(Root.self)

        graph.install(module: self)

        try graph.finalize()
        
        return p.get()
    }
}

