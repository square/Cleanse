//
//  ProviderBuilders.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// Represents a partial reference provider value. Exposes public method needed to fill in the missing
/// properties and then build the resulting `ReferenceProvider`.
public struct ReferenceProviderBuilder {
    public enum ResultingProvider {
        case reference(ReferenceProvider)
        case standard(StandardProvider)
    }
    let type: String
    let tag: String?
    let scope: String?
    let collectionType: String?
    let dependencies: [String]?
    let reference: String?
    let debugData: DebugData
    
    // A potential reference provider can turn into a standard provider
    // by passing a closure to the configured function.
    public func build() -> ResultingProvider {
        precondition(dependencies != nil || reference != nil, "Must supply a dependencies list or reference before building.")
        if let dependencies = dependencies {
            return .standard(StandardProvider(
                type: type,
                dependencies: dependencies,
                tag: tag,
                scoped: scope,
                collectionType: collectionType,
                debugData: debugData
            ))
        }
        if let reference = reference {
            return .reference(ReferenceProvider(
                type: type,
                tag: tag,
                scoped: scope,
                collectionType: collectionType,
                reference: reference,
                debugData: debugData
            ))
        }
        
        fatalError("Cannot reach via precondition.")
    }
    
    public func setReference(reference: String) -> ReferenceProviderBuilder {
        return ReferenceProviderBuilder(
            type: type,
            tag: tag,
            scope: scope,
            collectionType: collectionType,
            dependencies: nil,
            reference: reference,
            debugData: debugData
        )
    }
    
    public func setDependencies(dependencies: [String]) -> ReferenceProviderBuilder {
        return ReferenceProviderBuilder(
            type: type,
            tag: tag,
            scope: scope,
            collectionType: collectionType,
            dependencies: dependencies,
            reference: nil,
            debugData: debugData
        )
    }
}

/// Represents a partial dangling provider value. Exposes public method needed to fill in the missing
/// properties and then build the resulting `DanglingProvider`.
public struct DanglingProviderBuilder {
    let type: String
    let dependencies: [String]
    let reference: String?
    let debugData: DebugData
    
    public func setReference(_ reference: String) -> DanglingProviderBuilder {
        return DanglingProviderBuilder(type: type, dependencies: dependencies, reference: reference, debugData: debugData)
    }
    
    public func build() -> DanglingProvider {
        precondition(reference != nil, "Must set a reference on the builder before building.")
        return DanglingProvider(
            type: type,
            dependencies: dependencies,
            reference: reference!,
            debugData: debugData
        )
    }
}
