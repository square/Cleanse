//
//  ResolutionError.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

public struct ResolutionError: Equatable, Error {
    public enum Error: Equatable {
        case missingModule(String)
        case missingSubcomponent(String)
        case duplicateProvider([CanonicalProvider])
        case missingProvider(dependency: TypeKey, dependedUpon: CanonicalProvider?, suggestedModules: [String] = [])
        case cyclicalDependency(chain: [TypeKey])
    }
    
    let type: Error
}

extension ResolutionError: CustomStringConvertible {
    public var description: String {
        switch type {
        case .missingProvider(let provider, let parent, let suggestedModules):
            var errorDescription = "Missing Provider: '\(provider.primaryType)'\n"
            if let p = parent {
                errorDescription += "Depended upon by: '\(p.type)'\n"
            }
            
            if suggestedModules.count > 0 {
                errorDescription += suggestedModules
                    .map { "Found in '\($0)'. Perhaps 'binder.include(module: \($0).self)'".notePrefixed() }
                    .joined(separator: "\n") + "\n"
            }
            return errorDescription.errorPrefixed(data: parent?.debugData)
        case .missingSubcomponent(let subcomponent):
            return "error: Missing installed Component: '\(subcomponent)'\n"
        case .missingModule(let module):
            return "error: Missing included Module: '\(module)'\n"
        case .duplicateProvider(let providers):
            let first = providers.first!
            let duplidateBindings = providers.suffix(from: 1)
            var errorDescription = "Duplicate binding for '\(first.type)'\n"
            
            errorDescription += duplidateBindings
                .filter { $0.debugData.location != nil }
                .map { "'\($0.type)' previously bound here.".notePrefixed(data: $0.debugData) }
                .joined(separator: "\n") + "\n"
            
            return errorDescription.errorPrefixed(data: first.debugData)
        case .cyclicalDependency(let chain):
            let chainDescription = chain.map { $0.primaryType }.joined(separator: " --> ")
            return "error: Cycle in dependencies found: \(chainDescription)"
        }
    }
}

fileprivate extension String {
    func notePrefixed(data: DebugData? = nil) -> String {
        let prefix: String
        if let location = data?.location {
            prefix = "\(location): note: \(self)"
        } else {
            prefix = "note: \(self)"
        }
        return prefix
    }
    
    func errorPrefixed(data: DebugData? = nil) -> String {
        let prefix: String
        if let location = data?.location {
            prefix = "\(location): error: \(self)"
        } else {
            prefix = "error: \(self)"
        }
        return prefix
    }
}
