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


public protocol RootComponent : Component, _AnyRootComponent {
    associatedtype Scope = Singleton
}

public extension ComponentFactoryProtocol {
    public static func of(_ componentType: ComponentElement.Type, validate: Bool = true) throws -> ComponentFactory<ComponentElement>  {

        if validate {
            let validator = SatisfiedDependenciesValidationVisitor()
            validator.install(dependency: ComponentElement.self)
            try validator.finalize()
        }
        
        let graph = Graph(scope: nil)

        let p = graph.provider(ComponentFactory<ComponentElement>.self)

        graph.install(dependency: ComponentElement.self)
        
        try graph.finalize()

        return p.get()
    }
}



extension Component {
    // Returns true if we're a RootComponents
    static var isRootComponent: Bool {
        return self is _AnyRootComponent.Type
    }
}
