//
//  SyntaxVisitorExtension.swift
//  swift-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public extension SyntaxVisitor {
    mutating func walkChildren(_ node: Syntax) {
        node.children.forEach { walk($0) }
    }
}
