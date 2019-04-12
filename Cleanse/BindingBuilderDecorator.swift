//
//  BindingBuilderDecorator.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/9/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol BindingBuilderDecorator : BindingBuilder {
    associatedtype Wrapped: BindingBuilder
    
    init(wrapped: Wrapped)
    var wrapped: Wrapped { get }
    
    /// Support for collection binding. Users probably don't have to worry about this. Also they have default implementations
    /// TODO: Move elsewhere perhaps
    associatedtype MaybeScope  = Wrapped.MaybeScope
    associatedtype Input = Wrapped.Input
    associatedtype Binder = Wrapped.Binder
    associatedtype FinalProvider = Wrapped.FinalProvider
    
    associatedtype CollectionOrUnique = Wrapped.CollectionOrUnique
    
    static var collectionMergeFunc: Optional<([FinalProvider.Element]) -> FinalProvider.Element> { get }
}


extension BindingBuilderDecorator where FinalProvider.Element == Wrapped.FinalProvider.Element {
    public static var collectionMergeFunc: Optional<([FinalProvider.Element]) -> FinalProvider.Element> {
        guard let wrappedF = Wrapped.collectionMergeFunc else {
            return nil
        }
        
        return wrappedF
    }
}

extension BindingBuilderDecorator where Self.Binder == Wrapped.Binder {
    public var binder: Self.Binder {
        return wrapped.binder
    }
}

extension BindingBuilderDecorator where Input == Wrapped.Input, FinalProvider.Element == Wrapped.FinalProvider.Element {
    public static func mapElement(input: Input) -> FinalProvider.Element {
        return Wrapped.mapElement(input: input)
    }
}

