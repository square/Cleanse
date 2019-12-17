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

public final class ComponentFactory<C: ComponentBase> : ComponentFactoryProtocol {
    public typealias ComponentElement = C
    fileprivate let factoryFunction: (_ seed: ComponentElement.Seed, _ subgraph: Graph) -> C.Root
    fileprivate let parent: Graph?
    fileprivate var subgraphs: [Graph] = []

    init(parent: Graph?, factoryFunction: @escaping (_ seed: ComponentElement.Seed, _ subgraph: Graph) -> C.Root) {
        self.factoryFunction = factoryFunction
        self.parent = parent
    }

    /// Builds the Component and returns its root object.
    public func build(_ seed: ComponentElement.Seed) -> ComponentElement.Root {
        let subgraph = Graph(scope: C.Scope.scopeOrNil, parent: parent)
        subgraphs.append(subgraph)
        return factoryFunction(seed, subgraph)
    }
}

extension ComponentFactoryProtocol where ComponentElement.Seed: ProviderProtocol {
    public func build(_ seed: ComponentElement.Seed.Element) -> ComponentElement.Root {
        return build(ComponentElement.Seed.init(value: seed))
    }
}
