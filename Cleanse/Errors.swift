//
//  Errors.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/// All errors emitted by Cleanse implement this protocol
public protocol CleanseError : Error, CustomStringConvertible {
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
        var result = "\nMultiple Errors"
        
        let cnt = errors.count
        
        for (i, e) in errors.enumerated() {
            result += "\nerror \(i+1)/\(cnt):\n\(e.description)"
        }

        return result + "\n"
    }
}

private func canonicalDisplayType(_ t: Any.Type) -> Any.Type {
        if let t = t as? _AnyStandardProvider.Type {
            return t.providesType
        }

        return t
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
        var message = "*** \(canonicalDisplayType(requestedType)) *** binding missing"
        
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
                message += " required by \(canonicalDisplayType(providerRequiredFor))"
            }

            if let sourceLocation = r.sourceLocation {
                maybeDoNewLine()
                
                let trimmedSourceLocation = String(describing: sourceLocation).components(separatedBy: "/").suffix(2).joined(separator: "/")
                
                message += " at \(trimmedSourceLocation)"
            }
        }
        

        return message
    }
}

/// Error used to indicate that there is an unbroken dependency cycle
public struct DependencyCycle : CleanseError {
    /// The types that depend on the requested type
    let requirementStack: [ProviderRequestDebugInfo]

    /// The type that was requested
    var requestedType: Any.Type {
        return requirementStack[0].requestedType
    }

    init(requirementStack: [ProviderRequestDebugInfo]) {
        precondition(!requirementStack.isEmpty)
        self.requirementStack = requirementStack
    }

    public var description: String {
        var message = "*** \(canonicalDisplayType(requestedType)) *** Dependency Cycle Detected"

        for r in requirementStack {
            message += "\n  -> required by \(canonicalDisplayType(r.requestedType))"

            if let sourceLocation = r.sourceLocation {
                let trimmedSourceLocation = String(describing: sourceLocation).components(separatedBy: "/").suffix(2).joined(separator: "/")

                message += " at \(trimmedSourceLocation)"
            }
        }
        
        return message
    }
}

/// Error used to indicate that two components contain each other that have the same scope
public struct InvalidScopeNesting : CleanseError {
    let scope: Scope.Type

    let innerComponent: Any.Type
    let outerComponent: Any.Type

    public var description: String {
        return "Component (\(outerComponent)) contains a component (\(innerComponent)) with the same scope: (\(scope))"
    }
}

