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
        case duplicateProvider(CanonicalProvider)
        case missingProvider(dependency: String, dependedUpon: CanonicalProvider?)
        case cyclicalDependency(chain: [String])
    }
    
    let type: Error
}

extension ResolutionError: CustomStringConvertible {
    public var description: String {
        switch type {
        case .missingProvider(let provider, let parent):
            var base = "Missing Provider: \(provider).\n"
            if let p = parent {
                let indent = String(repeatElement(" ", count: 2))
                base += "\(indent)Depended upon by: \(p.type):\(p.debugData.location ?? "")\n\(indent)\(p.type) --> \(provider)\n"
            }
            return base
        case .missingSubcomponent(let subcomponent):
            return "Missing Installed Compoment: \(subcomponent)."
        case .missingModule(let module):
            return "Missing included Module: \(module)."
        case .duplicateProvider(let provider):
            return "Duplicate binding for \(provider.type): \(provider.debugData.location ?? "")"
        case .cyclicalDependency(let chain):
            let chainDescription = chain.joined(separator: " --> ")
            return "Cycle in dependencies found: \(chainDescription)"
        }
    }
}
