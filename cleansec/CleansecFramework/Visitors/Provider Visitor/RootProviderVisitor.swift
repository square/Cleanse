//
//  RootProviderVisitor.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 9/24/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

struct RootProviderVisitor: SyntaxVisitor {
    private var rootDanglingProvider: DanglingProvider? = nil
    
    mutating func visit(node: CallExpr) {
        if node.isCleanseBinding {
            var danglingProviderVisitor = DanglingProviderVisitor()
            danglingProviderVisitor.walk(node)
            rootDanglingProvider = danglingProviderVisitor.finalize()
        }
    }
    
    func finalize() -> DanglingProvider? {
        rootDanglingProvider
    }
    
    struct DanglingProviderVisitor: SyntaxVisitor {
        private var danglingProviderBuilder = DanglingProviderBuilder()
        
        mutating func visit(node: DeclrefExpr) {
            guard let api = BindingAPI.allCases.first(where: { (bindingApi) -> Bool in
                node.raw.contains(bindingApi.rawValue)
            }) else {
                return
            }
            
            switch api {
            case .toValue:
                danglingProviderBuilder.dependencies = []
            case .toFactory, .toFactoryPropertyInjector, .toFactoryAssistedInjection:
                let dependencies = node.raw.allCaptures(#"\(substitution\sP_[\d]+\s->\s(\(\).*?|.*?)(?=\)\s|\)\)])"#)
                danglingProviderBuilder.dependencies = dependencies
            }
        }
        
        mutating func visit(node: CallExpr) {
            if let receiptType = node.type.firstCapture("BindingReceipt<(.*)>") {
                if let loc = node.raw.firstCapture(#"location=(.*)\srange"#) {
                    danglingProviderBuilder.debugData = .location(loc)
                }
                if let danglingProviderType = receiptType.firstCapture(#"^ReceiptBinder<(.*)>"#) {
                    danglingProviderBuilder.type = danglingProviderType
                } else if let danglingPropertyInjectorType = receiptType.firstCapture(#"PropertyInjectionReceiptBinder<(.*)>\.Element>"#) {
                    danglingProviderBuilder.type = "PropertyInjector<\(danglingPropertyInjectorType)>"
                } else if receiptType.matches(#"^PropertyInjector<.*>"#) {
                    danglingProviderBuilder.type = receiptType
                }
                return
            }
        }
        
        func finalize() -> DanglingProvider? {
            return danglingProviderBuilder.finalize()
        }
    }
    
    
    fileprivate struct DanglingProviderBuilder {
        var type: String? = nil
        var debugData: DebugData? = nil
        var dependencies: [String]? = nil
        
        func finalize() -> DanglingProvider? {
            guard let type = type, let dependencies = dependencies else {
                return nil
            }
            return DanglingProvider(type: type, dependencies: dependencies, debugData: debugData ?? .empty)
        }
    }
    
}
