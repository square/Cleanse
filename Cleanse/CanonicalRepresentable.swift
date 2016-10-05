//
//  CanonicalRepresentable.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/3/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

protocol AnyCanonicalRepresentable {
    static var canonicalProviderType: AnyProvider.Type { get }
    static func transformFromCanonicalAnyCanonical(canonicalProvider: AnyProvider) -> AnyProvider
}

protocol CanonicalRepresentable : AnyCanonicalRepresentable {
    associatedtype Canonical
    
    static func transformFromCanonicalCanonical(canonical: Canonical) -> Self
}

extension CanonicalRepresentable {
    static var canonicalProviderType: AnyProvider.Type {
        return Provider<Canonical>.self
    }
    
    static func transformFromCanonicalAnyCanonical(canonicalProvider: AnyProvider) -> AnyProvider {
        let typedProvider = canonicalProvider.asCheckedProvider(Canonical.self)
        return typedProvider.map(transform: Self.transformFromCanonicalCanonical)
    }
}

extension ImplicitlyUnwrappedOptional : CanonicalRepresentable {
    typealias Canonical = Wrapped

    static func transformFromCanonicalCanonical(canonical: Wrapped) -> ImplicitlyUnwrappedOptional {
        return canonical
    }
}

extension Optional : CanonicalRepresentable {
    typealias Canonical = Wrapped
    
    static func transformFromCanonicalCanonical(canonical: Wrapped) -> Optional {
        return canonical
    }
}

#if SUPPORT_LEGACY_OBJECT_GRAPH
    
    extension NSString : CanonicalRepresentable {
        public typealias Canonical = String
        
        class func transformFromCanonicalCanonical(canonical canonical: String) -> Self {
            return .init(string: canonical)
        }
    }
    
#endif

//extension Provider : CanonicalRepresentable {
//    public typealias Canonical = Element
//    
//    
//    static func transformFromCanonicalCanonical(canonical canonical: Element) -> Provider {
//        return Provider(value: canonical)
//    }
//}
