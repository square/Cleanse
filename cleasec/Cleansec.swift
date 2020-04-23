//
//  Cleansec.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

public struct Cleansec {
    public static func analyze(nodes: [Syntax], searchNodes: [ModuleOutput]) {
        nodes.map { syntax -> FileRepresentation in
            var fileVisitor = FileVisitor()
            fileVisitor.walk(syntax)
            return fileVisitor.finalize()
        }
    }
    
    public static func analyze(text: String, searchNodes: [ModuleOutput]) {
        let nodes = NodeSyntaxParser.parse(text: text)
        analyze(nodes: nodes, searchNodes: searchNodes)
    }
}
