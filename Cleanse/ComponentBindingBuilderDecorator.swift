//
//  ComponentBindingBuilderDecorator.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/9/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

public struct ComponentBindingBuilderDecorator<Wrapped: BindingBuilder
                                                    where
                                                Wrapped.FinalProvider.Element: Component,
                                                Wrapped.MaybeScope == _Unscoped,
                                                Wrapped.FinalProvider: _StandardProvider,
                                                Wrapped.CollectionOrUnique == _UniqueBinding
                                            >
                                            : BindingBuilderDecorator {
    public typealias MaybeComponentOrSubcomponent = Wrapped.FinalProvider.Element
    
    public typealias Input = MaybeComponentOrSubcomponent
    public typealias FinalProvider = Provider<MaybeComponentOrSubcomponent.Root>
    
    public let wrapped: Wrapped
    
    public init(wrapped: Wrapped) {
        self.wrapped = wrapped
    }

    public static var collectionMergeFunc: Optional<[FinalProvider.Element] -> FinalProvider.Element> {
        return nil
    }
    
    public static func mapElement(input input: Input) -> FinalProvider.Element {
        return try! input.build()
    }
}

public extension Binder {
    /// Intitiates a component binding sequence. The component's `Root` type will be provided into the object graph.
    /// - Note: `bindComponent` API is experimental at best, and may just go away. Please don't depend on it too much. They are somewhat of a leaky abstraction, but make testing a lot easier
    @warn_unused_result
    public func bindComponent<Element: Component>(_ type: Element.Type = Element.self) -> ComponentBindingBuilderDecorator<BaseBindingBuilder<Element, Self>> {
        return BaseBindingBuilder(binder: self).with()
    }
}