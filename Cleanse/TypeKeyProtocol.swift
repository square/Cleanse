//
//  TypeKeyProtocol.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/29/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation

/// An implementation of this is used to have a hashable of a type.
/// This is preferable to using ObjectIdentifier since it can be typed and has a better description
public protocol TypeKeyProtocol : DelegatedHashable, CustomStringConvertible {
    var type: Any.Type { get }
}

extension TypeKeyProtocol {
    public var hashable: ObjectIdentifier {
        return ObjectIdentifier(type)
    }
    
    public var description: String {
        return "\(type)"
    }
}

