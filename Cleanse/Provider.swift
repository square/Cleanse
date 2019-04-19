//
//  Provider.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/**
 Protocol for providers. The canonical implementation is `Provider`, but `TaggedProvider` exists as well.
 */
public protocol ProviderProtocol {
    /// Element type of the provider. Its what get returns
    associatedtype Element
    
    init<P: ProviderProtocol>(other: P) where P.Element == Element
    init(value: Element)
    init(getter: @escaping ()-> Element)

    /// - returns: provides an instance of `Element`
    func get() -> Element
}


public extension ProviderProtocol {
    init(value: Element) {
        self.init(getter: { value })
    }

    init<P: ProviderProtocol>(other: P) where P.Element == Element {
        self.init(getter: other.get)
    }
}


protocol AnyProvider {
    static var providesType: Any.Type { get }
    var instanceProvidesType: Any.Type { get }
    
    func getAny() -> Any
    
    /// Of type Provider<() -> Element>
    var anyGetterProvider: AnyProvider? { get }
    
    static func makeNew(getter: @escaping ()-> Any) -> AnyProvider

    func asCheckedProvider<Element>(_ type: Element.Type) -> Provider<Element>
    
    
    /// If we're Provider<Provider<Element>> flatten to just be Provider<Element>.
    func flatten<Element>(_ type: Element.Type) -> Provider<Element>
    

    static var anyProviderToClosureType: AnyProvider.Type { get }
}

extension AnyProvider {
    /// Tries to go from untyped `AnyProvider` to original provider
    func asCheckedProvider<Element>(_ type: Element.Type) -> Provider<Element> {
        precondition(Element.self == instanceProvidesType, "When converting to a checked provider, requested type \(type) is not equal to actual type \(instanceProvidesType)")
        let anyProvider = getAny
        return Provider { anyProvider() as! Element }
    }
}

extension AnyProvider {
    /// Applies a transform to Element and returns a typed provider
    func map<NewE>(transform: @escaping (Any) -> NewE) -> Provider<NewE> {
        return Provider { transform(self.getAny()) }
    }
}


extension ProviderProtocol {
    /// Applies a transform to Element and returns the resulting provider
    public func map<NewE>(transform: @escaping (Element) -> NewE) -> Provider<NewE> {
        return Provider {
            let originalValue = self.get()
            return transform(originalValue)
        }
    }
}

/// This can be added as to request lazy evaluation of something.
/// Note, in general requesting () -> Element is appropriate, aside from component construction arguments.
/// This is because we have to be able to detect the arguments for components to give a noop provider
public struct Provider<Element> : ProviderProtocol {
    let getter: ClosureType
    
    typealias ClosureType = () -> Element
    
    public init(getter: @escaping () -> Element) {
        self.getter = getter
    }

    public init<P : ProviderProtocol>(other: P) where P.Element == Element {
        self.getter = other.get
    }

    public func get() -> Element {
        return getter()
    }
}

extension Provider : AnyProvider {
    static func makeNew(getter: @escaping () -> Any) -> AnyProvider {
        return Provider(getter: { getter() as! Element })
    }
    
    var anyGetterProvider: AnyProvider? {
        return Provider<() -> Element>(value: getter)
    }
}

// To make it conform to AnyProvider
extension ProviderProtocol where Self: AnyProvider {
    var instanceProvidesType: Any.Type {
        return Element.self
    }
    
    static var providesType: Any.Type {
        return Element.self
    }
    
    func getAny() -> Any {
        return get()
    }
    
    func flatten<CheckedE>(_ type: CheckedE.Type) -> Provider<CheckedE> {
        precondition(Element.self is AnyProvider.Type, "Can only call flatten on Provider<Provider<Element>>")
        precondition((Element.self as! AnyProvider.Type).providesType == CheckedE.self, "CheckedE must be Element.Element")
        
        _ = Element.self as! AnyProvider.Type
        
        let getter = self.get
        return Provider { (getter() as! AnyProvider).asCheckedProvider(CheckedE.self).get() }
    }
}
