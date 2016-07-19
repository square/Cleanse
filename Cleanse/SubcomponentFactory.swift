//
//  ComponentFactory.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Useful for extensions on `ComponentFactory` that also require
public protocol ComponentFactoryProtocol {
    associatedtype ComponentElement: Cleanse.Component

    func build(seed: ComponentElement.Seed) -> ComponentElement.Root
}

/// Instantiates a subcomponent and returns its root object.
public struct ComponentFactory<C: Component> : ComponentFactoryProtocol {
    public typealias ComponentElement = C
    private let factoryFunction: (seed: ComponentElement.Seed) -> C.Root

    public func build(seed: ComponentElement.Seed) -> ComponentElement.Root {
        return factoryFunction(seed: seed)
    }

    init(factoryFunction: (seed: ComponentElement.Seed) -> C.Root) {
        self.factoryFunction = factoryFunction
    }
}

extension ComponentFactoryProtocol where ComponentElement.Seed: ProviderProtocol {

    /// Convenience initializer to construct subcomponents which have seeds of Provider types such as `TaggedProvider`s.

    public func build(seed: ComponentElement.Seed.Element) -> ComponentElement.Root {
        return build(ComponentElement.Seed.init(value: seed))
    }

}
