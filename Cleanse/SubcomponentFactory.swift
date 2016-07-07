//
//  SubcomponentFactory.swift
//  Cleanse
//
//  Created by Mike Lewis on 7/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// Useful for extensions on `SubcomponentFactory` that also require
public protocol SubcomponentFactoryProtocol {
    associatedtype SubcomponentElement: Cleanse.Subcomponent

    func build(seed: SubcomponentElement.Seed) -> SubcomponentElement.Root
}

/// Instantiates a subcomponent and returns its root object.
public struct SubcomponentFactory<S: Subcomponent> : SubcomponentFactoryProtocol {
    public typealias SubcomponentElement = S
    private let factoryFunction: (seed: SubcomponentElement.Seed) -> S.Root

    public func build(seed: SubcomponentElement.Seed) -> SubcomponentElement.Root {
        return factoryFunction(seed: seed)
    }

    init(factoryFunction: (seed: SubcomponentElement.Seed) -> S.Root) {
        self.factoryFunction = factoryFunction
    }
}

extension SubcomponentFactoryProtocol where SubcomponentElement.Seed: ProviderProtocol {

    /// Convenience initializer to construct subcomponents which have seeds of Provider types such as `TaggedProvider`s.

    public func build(seed: SubcomponentElement.Seed.Element) -> SubcomponentElement.Root {
        return build(SubcomponentElement.Seed.init(value: seed))
    }

}