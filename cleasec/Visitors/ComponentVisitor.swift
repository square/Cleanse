//
//  ComponentVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

enum ComponentSeed {
    case void
    case type(String)
}

struct ComponentVisitor: SyntaxVisitor {
    var seed = "Void"
    
    mutating func visit(node: Typealias) {
        if node.raw.contains("\"Seed\"") {
            if let type = node.type.firstCapture(pattern: #"'(\w+)'"#), type != "Void" {
                seed = type
            }
        }
    }
}
