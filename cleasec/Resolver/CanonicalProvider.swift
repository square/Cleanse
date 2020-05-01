//
//  CanonicalProvider.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/24/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation


public struct CanonicalProvider {
    public let type: String
    public let dependencies: [String]
    public let isCollection: Bool
}

extension CanonicalProvider: CustomStringConvertible {
    public var description: String {
        "\(type) -> \(dependencies)"
    }
}

extension CanonicalProvider {
    var lazyProvider: CanonicalProvider {
        // Think about dependencies. Should there be none? The inner type, or all shared dependencies?
        return CanonicalProvider(type: "Provider<\(type)>", dependencies: [], isCollection: isCollection)
    }
}

extension StandardProvider {
    // Maps collection and tagged bindings into their canonical form.
    func mapToCanonicalProvider() -> CanonicalProvider {
        if let tagged = tag {
            // As of today, it is not possible to have a tagged and collection provider
            return CanonicalProvider(type: "TaggedProvider<\(tagged)>", dependencies: dependencies, isCollection: false)
        }
        if let collection = collectionType {
            return CanonicalProvider(type: collection, dependencies: dependencies, isCollection: true)
        }
        return CanonicalProvider(type: type, dependencies: dependencies, isCollection: false)
    }
}

