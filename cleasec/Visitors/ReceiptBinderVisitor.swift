//
//  ReceiptBinderVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

struct ReceiptBinderVisitor: SyntaxVisitor {
    let type: String
    
    var reference: String? = nil
    mutating func visit(node: DeclrefExpr) {
        if node.type == "ReceiptBinder<\(type)>" {
            reference = node.raw.firstCapture(pattern: #"decl=(.*)\.\w+@"#)
        }
    }
}
