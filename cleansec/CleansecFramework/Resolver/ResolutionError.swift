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
        case duplicateProvider(String)
        case missingProvider(String)
    }
    
    let type: Error
}

extension ResolutionError: CustomStringConvertible {
    public var description: String {
        switch type {
        case .missingProvider(let provider):
            return "Missing Provider: \(provider)."
        case .missingSubcomponent(let subcomponent):
            return "Missing Installed Compoment: \(subcomponent)."
        case .missingModule(let module):
            return "Missing included Module: \(module)."
        case .duplicateProvider(let provider):
            return "Duplicate binding for: \(provider)"
        }
    }
}
