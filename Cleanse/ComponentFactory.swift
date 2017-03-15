//
//  ComponentFactory.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public protocol ComponentFactoryProtocol {
    associatedtype ComponentElement: Cleanse.ComponentBase

    func build(_ seed: ComponentElement.Seed) -> ComponentElement.Root
}

public struct ComponentFactory<C: ComponentBase> : ComponentFactoryProtocol {
    public typealias ComponentElement = C
    fileprivate let factoryFunction: (_ seed: ComponentElement.Seed) -> C.Root

    init(factoryFunction: @escaping (_ seed: ComponentElement.Seed) -> C.Root) {
        self.factoryFunction = factoryFunction
    }

    /// Builds the Component and returns its root object.
    public func build(_ seed: ComponentElement.Seed) -> ComponentElement.Root {
        return factoryFunction(seed)
    }
}

extension ComponentFactoryProtocol where ComponentElement.Seed: ProviderProtocol {
    public func build(_ seed: ComponentElement.Seed.Element) -> ComponentElement.Root {
        return build(ComponentElement.Seed.init(value: seed))
    }
}
