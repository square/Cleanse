//
//  ReferenceVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

enum ReferenceType {
    case unknown
    case reference(String)
    case provider(StandardProvider)
}

struct ReferenceVisitor: SyntaxVisitor {
    let type: String
    var referenceType: ReferenceType = .unknown
    
    mutating func visit(node: CallExpr) {
        var bindingVisitor = BindingVisitor(type: type)
        bindingVisitor.walk(node)
        switch bindingVisitor.binding {
        case .provider:
            referenceType = .provider(StandardProvider(
                type: type,
                dependencies: bindingVisitor.dependencies,
                tag: nil,
                scoped: nil))
        default:
            break
        }
    }
    
    mutating func visit(node: DeclrefExpr) {
        let receiptBinderType: String
        let bindingReceiptType = "BindingReceipt<\(type)>"
        if let innerPropertyInjectorType = type.firstCapture(pattern: "PropertyInjector<(.*)>") {
            receiptBinderType = "PropertyInjectionReceiptBinder<\(innerPropertyInjectorType)>"
        } else {
            receiptBinderType = "ReceiptBinder<\(type)>"
        }
        let pattern = "->\\s\\(\(receiptBinderType)\\) -> \(bindingReceiptType)"        
        guard node.raw.contains(pattern: pattern), let reference = node.raw.firstCapture(pattern: #"decl=(.*)@"#) else {
            return
        }
        referenceType = .reference(reference)
    }
}
