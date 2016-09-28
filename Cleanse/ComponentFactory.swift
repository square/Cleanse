//
//  ComponentFactory.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public protocol ComponentFactoryProtocol {
    associatedtype ComponentElement: Cleanse.Component

    func build(seed: ComponentElement.Seed) -> ComponentElement.Root
}

public struct ComponentFactory<C: Component> : ComponentFactoryProtocol {
    public typealias ComponentElement = C
    private let factoryFunction: (seed: ComponentElement.Seed) -> C.Root

    init(factoryFunction: (seed: ComponentElement.Seed) -> C.Root) {
        self.factoryFunction = factoryFunction
    }

    /// Builds the Component and returns its root object.
    public func build(seed: ComponentElement.Seed) -> ComponentElement.Root {
        return factoryFunction(seed: seed)
    }
}

extension ComponentFactoryProtocol where ComponentElement.Seed: ProviderProtocol {
    public func build(seed: ComponentElement.Seed.Element) -> ComponentElement.Root {
        return build(ComponentElement.Seed.init(value: seed))
    }
}
