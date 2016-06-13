//
//  Errors.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


#if !swift(>=3.0)
    public typealias ErrorProtocol = ErrorType
#endif


/// All errors emitted by Cleanse implement this protocol
public protocol CleanseError : ErrorProtocol, CustomStringConvertible {
}


public struct ProviderRequestDebugInfo {
    
    /// This is what was passed to the first argument of
    let requestedType: Any.Type
    
    /// If we know this is a dependency for another provider, this can be populated. We don't always know, however.
    let providerRequiredFor: Any.Type?
    
    /// Source location at application level where this provider was requested. We also may not have this
    let sourceLocation: SourceLocation?
}

/// Represents multiple cleanse errors
public struct MultiError : CleanseError {
    /// The sub-errors
    public let errors: [CleanseError]
    
    public var description: String {
        var result = "Multiple Errors"
        
        let cnt = errors.count
        
        for (i, e) in errors.enumerated() {
            result += "\nerror \(i+1)/\(cnt):\n\(e.description)"
        }
        
        return result
    }
}

/// Error used to indicate that a provider requirement is unmet.
public struct MissingProvider : CleanseError {
    /// The types that depend on the requested type
    let requests: [ProviderRequestDebugInfo]

    /// The type that was requested
    var requestedType: Any.Type {
        return requests[0].requestedType
    }
    
    /// cannot be empty. All types are assumed to be the same
    init(requests: [ProviderRequestDebugInfo]) {
        precondition(!requests.isEmpty)
        self.requests = requests
    }
    
    public var description: String {
        var message = "*** \(requestedType) *** binding missing"
        
        for r in requests {
            var didNewLine = false
            
            func maybeDoNewLine() {
                if didNewLine {
                    return
                }
                
                didNewLine = true
                message += "\n  ->"
            }
            
            if let providerRequiredFor = r.providerRequiredFor {
                maybeDoNewLine()
                message += " required by \(providerRequiredFor)"
            }

            if let sourceLocation = r.sourceLocation {
                maybeDoNewLine()
                
                let trimmedSourceLocation = String(sourceLocation).components(separatedBy: "/").suffix(2).joined(separator: "/")
                
                message += " at \(trimmedSourceLocation)"
            }
            

        }
        

        return message
    }
}


