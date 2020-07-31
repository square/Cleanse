//
//  TypeKey.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 7/31/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/// Normalized type representation.
/// A single type can be represented in a few different ways: `() -> Type`, `WeakProvider<Type>`, `Provider<Type>`, or just `Type`.
/// This normalizes the type into the canonical `Provider<Type>` that can be used for key lookup and comparisons.
public struct TypeKey: Hashable {
    private let rawType: String
    private let canonicalType: String
    
    public init(type: String) {
        self.rawType = type
        if type.isCanonicalProvider {
            self.canonicalType = type
        } else if type.isWeakProvider, let innerType = type.firstCapture(#"^WeakProvider<(.*)>"#) {
            self.canonicalType = "Provider<\(innerType)>"
        } else if type.isImplicitProvider, let innerType = type.firstCapture(#"^\(\)\s->\s(.*)"#) {
            self.canonicalType = "Provider<\(innerType)>"
        } else {
            self.canonicalType = "Provider<\(type)>"
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(canonicalType)
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
         return lhs.canonicalType == rhs.canonicalType
    }
}

extension TypeKey {
    var isWeakProvider: Bool {
        rawType.isWeakProvider
    }
    
    var primaryType: String {
        guard let inner = canonicalType.firstCapture(#"Provider<(.*)>"#) else {
            return rawType
        }
        return inner
    }
}

extension TypeKey: CustomStringConvertible {
    public var description: String {
        canonicalType
    }
}

fileprivate extension String {
    var isCanonicalProvider: Bool {
        matches("^Provider<.*>")
    }
    
    var isImplicitProvider: Bool {
        matches(#"^\(\)\s->\s.*"#)
    }
    
    var isWeakProvider: Bool {
        matches("^WeakProvider<.*>")
    }
}
