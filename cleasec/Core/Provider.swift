//
//  Provider.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

public struct Provider: Equatable {
    public let type: String
    public let dependencies: [String]
    public let tag: String?
    public let scoped: String?
}

public struct DanglingProvider: Equatable {
    public let type: String
    public let dependencies: [String]
    public let reference: String
}

public struct ReferenceProvider {
    public let type: String
    public let tag: String?
    public let scoped: String?
    public let reference: String
}
