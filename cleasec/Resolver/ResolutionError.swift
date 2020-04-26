//
//  ResolutionError.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/24/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public struct ResolutionError: Error {
    public enum ErrorType {
        case missingModule(String)
        case missingComponent(String)
        case missingDependency(String)
        case duplicateDependency(String)
        case cyclicalDependencies([String])
    }
    
    public let error: ErrorType
}
