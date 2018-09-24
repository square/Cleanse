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

// XC 9 Support. In XC 10, ImplicitlyUnwrappedOptional is removed in Swift v4.2. There is a source break
// during compatibility mode when compiling swift 3 code that also makes the compiler think that the
// ImplicitlyUnwrappedOptional has been renamed to Optional. Swift v4.2 (XC 10) during compatibility mode
// interprets swift 3 code as swift v3.4. For XC 9 and below (where ImplicitlyUnwrappedOptional still exists),
// Swift 4 in compatibility mode inteprets swift 3 code as swift v3.3 and below. Hence, #if !swift(>=3.4).
#if !swift(>=3.4)
extension ImplicitlyUnwrappedOptional : CanonicalRepresentable {
    typealias Canonical = Wrapped
    static func transformFromCanonicalCanonical(canonical: Wrapped) -> ImplicitlyUnwrappedOptional {
        return canonical
    }
}
#endif

extension Optional : CanonicalRepresentable {
    typealias Canonical = Wrapped
    
    static func transformFromCanonicalCanonical(canonical: Wrapped) -> Optional {
        return canonical
    }
}

#if SUPPORT_LEGACY_OBJECT_GRAPH
    
    extension NSString : CanonicalRepresentable {
        public typealias Canonical = String
        
        class func transformFromCanonicalCanonical(canonical: String) -> Self {
            return .init(string: canonical)
        }
    }
    
#endif
