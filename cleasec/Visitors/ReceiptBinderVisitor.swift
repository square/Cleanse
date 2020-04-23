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
        let receiptBinderType: String
        if let innerPropertyInjectorType = type.firstCapture(pattern: "PropertyInjector<(.*)>") {
            receiptBinderType = "PropertyInjectionReceiptBinder<\(innerPropertyInjectorType)>"
        } else {
            receiptBinderType = "ReceiptBinder<\(type)>"
        }
        if node.type == receiptBinderType {
            reference = node.raw.firstCapture(pattern: #"decl=(.*)\.\w+@"#)
        }
    }
}
