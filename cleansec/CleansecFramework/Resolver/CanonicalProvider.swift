//
//  CanonicalProvider.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/// This is the final form of a provider used by dependency graphs.
/// For example, tagged providers with a special tag turn into `TaggedProvider<MyTag>`.
public struct CanonicalProvider: Equatable {
    public let type: String
    public let dependencies: [String]
    public let isCollectionProvider: Bool
}

extension CanonicalProvider: CustomStringConvertible {
    public var description: String {
        "Provider: \(type) --> \(dependencies)"
    }
}

extension CanonicalProvider {
    var lazyProvider: CanonicalProvider {
        return CanonicalProvider(
            type: "Provider<\(type)>",
            dependencies: dependencies,
            isCollectionProvider: isCollectionProvider
        )
    }
    
    var isLazyProvider: Bool {
        return type.matches("Provider<.*>")
    }
}

extension LinkedComponent {
    var seedProvider: CanonicalProvider {
        return CanonicalProvider(
            type: seed,
            dependencies: [],
            isCollectionProvider: false
        )
    }
    
    var componentFactoryProvider: CanonicalProvider {
        return CanonicalProvider(
            type: "ComponentFactory<\(type)>",
            dependencies: [],
            isCollectionProvider: false
        )
    }
}

extension StandardProvider {
    func mapToCanonical() -> CanonicalProvider {
        if let tag = tag {
            return CanonicalProvider(
                type: "TaggedProvider<\(tag)>",
                dependencies: dependencies,
                isCollectionProvider: false
            )
        }
        if let collection = collectionType {
            return CanonicalProvider(
                type: collection,
                dependencies: dependencies,
                isCollectionProvider: true
            )
        }
        return CanonicalProvider(
            type: type,
            dependencies: dependencies,
            isCollectionProvider: false
        )
    }
}
