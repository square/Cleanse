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

public struct StandardProvider: Provider, Equatable {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
}

public struct DanglingProvider: Provider, Equatable {
    public let type: String
    public let dependencies: [String]
    public let reference: String
}

public struct ReferenceProvider: Provider, Equatable {
    public let type: String
    public let tag: String?
    public let scoped: String?
    public let reference: String
}
