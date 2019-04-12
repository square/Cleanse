//
//  CollectionProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public struct CollectionBindingBuilderDecorator<Wrapped: BindingBuilder> : BindingBuilderDecorator  where Wrapped.CollectionOrUnique == _UniqueBinding, Wrapped.FinalProvider: _StandardProvider, Wrapped.MaybeScope == Unscoped {
    public typealias FinalProvider = Provider<[Wrapped.FinalProvider.Element]>
    public typealias Input = [Wrapped.Input]
    public typealias CollectionOrUnique = _CollectionBinding

    public let wrapped: Wrapped
    
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
    
    public static func mapElement(input: Input) -> FinalProvider.Element {
        return input.map(Wrapped.mapElement)
    }
    
    public static var collectionMergeFunc: Optional<([FinalProvider.Element]) -> FinalProvider.Element> {
        return { Array($0.joined()) }
    }
}

public extension BindingBuilder where CollectionOrUnique == _UniqueBinding, FinalProvider: _StandardProvider, MaybeScope == Unscoped {
    /// If makes it bind Element to [Element]
    func intoCollection() -> CollectionBindingBuilderDecorator<Self> {
        return with()
    }
}
