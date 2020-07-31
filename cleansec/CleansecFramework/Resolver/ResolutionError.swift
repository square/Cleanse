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
        case missingProvider(dependency: TypeKey, dependedUpon: CanonicalProvider?)
        case cyclicalDependency(chain: [TypeKey])
    }
    
    let type: Error
}

extension ResolutionError: CustomStringConvertible {
    public var description: String {
        switch type {
        case .missingProvider(let provider, let parent):
            var errorDescription = errorPrefix(debug: parent?.debugData)
            errorDescription += "Missing Provider: '\(provider.primaryType)'\n"
            if let p = parent {
                errorDescription += "Depended upon by: '\(p.type)'"
            }
            
            return errorDescription
        case .missingSubcomponent(let subcomponent):
            return "error: Missing Installed Compoment: '\(subcomponent)'"
        case .missingModule(let module):
            return "error: Missing included Module: '\(module)'"
        case .duplicateProvider(let providers):
            let first = providers.first!
            let duplidateBindings = providers.suffix(from: 1)
            var errorDescription = errorPrefix(debug: first.debugData)
            errorDescription += "Duplicate binding for '\(first.type)'\n"
            
            errorDescription += duplidateBindings
                .filter { $0.debugData.location != nil }
                .map { notePrefix(debug: $0.debugData) + "'\($0.type)' previously bound here." }
                .joined(separator: "\n")
            
            return errorDescription
        case .cyclicalDependency(let chain):
            let chainDescription = chain.map { $0.primaryType }.joined(separator: " --> ")
            return "error: Cycle in dependencies found: \(chainDescription)"
        }
    }
    
    private func notePrefix(debug: DebugData?) -> String {
        let prefix: String
        if let location = debug?.location {
            prefix = "\(location): note: "
        } else {
            prefix = "note: "
        }
        return prefix
    }
    
    private func errorPrefix(debug: DebugData?) -> String {
        let prefix: String
        if let location = debug?.location {
            prefix = "\(location): error: "
        } else {
            prefix = "error: "
        }
        return prefix
    }
}
