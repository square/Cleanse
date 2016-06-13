//
//  CollectionProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public struct CollectionBindingBuilderDecorator<Wrapped: BindingBuilder  where Wrapped.CollectionOrUnique == _UniqueBinding, Wrapped.FinalProvider: _StandardProvider, Wrapped.MaybeScope == _Unscoped> : BindingBuilderDecorator {
    public typealias FinalProvider = Provider<[Wrapped.FinalProvider.Element]>
    public typealias Input = [Wrapped.Input]
    public typealias CollectionOrUnique = _CollectionBinding

    public let wrapped: Wrapped
    
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }
    
    public static func mapElement(input input: Input) -> FinalProvider.Element {
        return input.map(Wrapped.mapElement)
    }
    
    public static var collectionMergeFunc: Optional<[FinalProvider.Element] -> FinalProvider.Element> {
        return { Array($0.flatten()) }
    }
}

public extension BindingBuilder where CollectionOrUnique == _UniqueBinding, FinalProvider: _StandardProvider, MaybeScope == _Unscoped {
    /// If makes it bind Element to [Element]
    @warn_unused_result
    public func intoCollection() -> CollectionBindingBuilderDecorator<Self> {
        return with()
    }
}