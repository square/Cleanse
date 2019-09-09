//
//  AssistedInjectionBuilder.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 9/5/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public protocol BaseAssistedInjectionBuilder {
    associatedtype Binder: BinderBase
    associatedtype Tag: AssistedFactory = EmptySeed<Element>
    associatedtype Element
    var binder: Binder { get }
}

public protocol AssistedInjectionBuilder : BaseAssistedInjectionBuilder where Tag.Element == Element {}

public struct AssistedInjectionBindingBuilder<B:BinderBase, E> : AssistedInjectionBuilder {
    public typealias Binder = B
    public typealias Element = E
    
    public let binder: Binder
}

extension AssistedInjectionBindingBuilder {
    public func with<S: AssistedFactory>(_ seed: S.Type) -> AssistedInjectionSeedDecorator<Binder, Element, S>  where S.Element == Element {
        return AssistedInjectionSeedDecorator(binder: binder)
    }
}
