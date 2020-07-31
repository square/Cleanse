//
//  CanonicalProvider.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// This is the final form of a provider used by dependency graphs.
/// For example, tagged providers with a special tag turn into `TaggedProvider<MyTag>`.
public struct CanonicalProvider: Equatable {
    public let type: TypeKey
    public let dependencies: [TypeKey]
    public let isCollectionProvider: Bool
    public let debugData: DebugData
}

extension CanonicalProvider: CustomStringConvertible {
    public var description: String {
        "Provider: \(type.primaryType) --> \(dependencies)"
    }
}

extension LinkedComponent {
    var seedProvider: CanonicalProvider {
        return CanonicalProvider(
            type: TypeKey(type: seed),
            dependencies: [],
            isCollectionProvider: false,
            debugData: .empty
        )
    }
    
    var componentFactoryProvider: CanonicalProvider {
        return CanonicalProvider(
            type: TypeKey(type: "ComponentFactory<\(type)>"),
            dependencies: [],
            isCollectionProvider: false,
            debugData: .empty
        )
    }
}

extension Array where Element == String {
    func mapTypesToKey() -> [TypeKey] {
        map { TypeKey(type: $0) }
    }
}

extension StandardProvider {
    func mapToCanonical() -> CanonicalProvider {
        if let tag = tag {
            return CanonicalProvider(
                type: TypeKey(type: "TaggedProvider<\(tag)>"),
                dependencies: dependencies.mapTypesToKey(),
                isCollectionProvider: collectionType != nil,
                debugData: debugData
            )
        }
        if let collection = collectionType {
            return CanonicalProvider(
                type: TypeKey(type: collection),
                dependencies: dependencies.mapTypesToKey(),
                isCollectionProvider: true,
                debugData: debugData
            )
        }
        return CanonicalProvider(
            type: TypeKey(type: type),
            dependencies: dependencies.mapTypesToKey(),
            isCollectionProvider: false,
            debugData: debugData
        )
    }
}
