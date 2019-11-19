//
//  CleanseErrorReporter.swift
//  Cleanse
//
//  Created by Sebastian Edward Shanus on 10/11/19.
//  Copyright © 2019 Square, Inc. All rights reserved.
//

import Foundation

public final class CleanseErrorReporter {
    var errors: [CleanseError] = []
    
    public func append(error: CleanseError) {
        errors.append(error)
    }
    
    public func append(contentsOf errorSet: [CleanseError]) {
        errors.append(contentsOf: errorSet)
    }
    
    func report() throws {
        errors.sort {
            return $0.description < $1.description
        }
        
        switch errors.count {
        case 0:
            // Everything is cool
            break
        case 1:
            throw errors[0]
        default:
            throw MultiError(errors: errors)
        }
    }
}
