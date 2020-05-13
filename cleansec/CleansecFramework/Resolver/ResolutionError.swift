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
