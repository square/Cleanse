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
    static func analyze(nodes: [Syntax]) -> LinkedInterface {
        Linker.linkProviders(
            files: nodes.map { syntax -> FileRepresentation in
                var fileVisitor = FileVisitor()
                fileVisitor.walk(syntax)
                return fileVisitor.finalize()
            }
        )
    }
    
    public static func analyze(text: String) -> LinkedInterface {
        let nodes = NodeSyntaxParser.parse(text: text)
        return analyze(nodes: nodes)
    }
}
