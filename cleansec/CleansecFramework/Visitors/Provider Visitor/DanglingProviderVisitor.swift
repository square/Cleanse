//
//  DanglingProviderVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

struct DanglingProviderVisitor: SyntaxVisitor {
    let type: String
    private var reference: String? = nil
    
    init(type: String) {
        self.type = type
    }
    
    mutating func visit(node: DeclrefExpr) {
        let receiptBinderType: String
        if let innerPropertyInjectorType = type.firstCapture("PropertyInjector<(.*)>") {
            receiptBinderType = "PropertyInjectionReceiptBinder<\(innerPropertyInjectorType)>"
        } else {
            receiptBinderType = "ReceiptBinder<\(type)>"
        }
        if node.type == receiptBinderType {
            reference = node.raw.firstCapture(#"decl=(.*)\.\w+@"#)
        }
    }
    
    func finalize() -> String? {
        return reference
    }
}
