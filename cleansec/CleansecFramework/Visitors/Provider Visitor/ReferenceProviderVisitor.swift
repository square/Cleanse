//
//  ReferenceProviderVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

enum ReferenceType {
    case unknown
    case reference(String)
    case dependencies([String])
}

struct ReferenceProviderVisitor: SyntaxVisitor {
    let type: String
    init(type: String) {
        self.type = type
    }
    
    private var referenceType: ReferenceType = .unknown
    
    mutating func visit(node: CallExpr) {
        var providerVisitor = ProviderVisitor(type: type)
        providerVisitor.walk(node)
        
        guard let result = providerVisitor.finalize() else {
            return
        }
        switch result {
        case .provider(let p):
            referenceType = .dependencies(p.dependencies)
        case .danglingProviderBuilder(let p):
            referenceType = .dependencies(p.dependencies)
        default:
            break
        }
    }
    
    mutating func visit(node: DeclrefExpr) {
        let receiptBinderType: String
        let bindingReceiptType = "BindingReceipt<\(type)>"
        if let innerPropertyInjectorType = type.firstCapture("PropertyInjector<(.*)>") {
            receiptBinderType = "PropertyInjectionReceiptBinder<\(innerPropertyInjectorType)>"
        } else {
            receiptBinderType = "ReceiptBinder<\(type)>"
        }
        let pattern = "->\\s\\(\(receiptBinderType)\\) -> \(bindingReceiptType)"
        guard node.raw.matches(pattern), let reference = node.raw.firstCapture(#"decl=(.*)@"#) else {
            return
        }
        referenceType = .reference(reference)
    }
    
    func finalize() -> ReferenceType {
        return referenceType
    }
}

