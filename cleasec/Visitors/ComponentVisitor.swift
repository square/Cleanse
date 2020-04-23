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
    var rootProvider: Provider?
    
    mutating func visit(node: Typealias) {
        if node.raw.contains("\"Seed\"") {
            if let type = node.type.firstCapture(pattern: #"'(\w+)'"#), type != "Void" {
                seed = type
            }
        }
    }
    
    mutating func visit(node: FuncDecl) {
        if node.raw.contains("configureRoot(binder:)") {
            var rootProviderVisitor = ConfigureVisitor()
            rootProviderVisitor.walk(node)
            guard let danglingRoot = rootProviderVisitor.danglingProviders.first else {
                return
            }
            rootProvider = Provider(
                type: danglingRoot.type,
                dependencies: danglingRoot.dependencies,
                tag: nil,
                scoped: nil)
        }
    }
    
}
