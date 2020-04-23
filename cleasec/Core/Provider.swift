//
//  Provider.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

public protocol Provider {
    var type: String { get }
}

public struct StandardProvider: Provider, Equatable, CustomStringConvertible {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
    
    public var description: String {
        "Standard-\(type): -> \(dependencies)"
    }
}

public struct DanglingProvider: Provider, Equatable, CustomStringConvertible {
    public let type: String
    public let dependencies: [String]
    public let reference: String
    
    public var description: String {
        "Dangling-\(type) -> \(dependencies)"
    }
}

public struct ReferenceProvider: Provider, Equatable, CustomStringConvertible {
    public let type: String
    public let tag: String?
    public let scoped: String?
    public let reference: String
    
    public var description: String {
        "Reference-\(type): \(reference)"
    }
}

