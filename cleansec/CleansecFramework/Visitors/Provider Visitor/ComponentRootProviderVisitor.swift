//
//  ComponentRootProviderVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

struct ComponentRootProviderVisitor: SyntaxVisitor {
    enum RootProvider {
        case dangling(DanglingProvider)
        case reference(ReferenceProvider)
    }
    
    private var seed = "Void"
    private var rootProvider: RootProvider?
    
    mutating func visit(node: Typealias) {
        if node.raw.contains("\"Seed\"") {
            if let type = node.type.firstCapture(#"'(\w+)'"#), type != "Void" {
                seed = type
            }
        }
    }
    
    mutating func visit(node: FuncDecl) {
        if node.raw.contains("configureRoot(binder:)") {
            var bindingsVisitor = BindingsVisitor()
            bindingsVisitor.walk(node)
            let result = bindingsVisitor.finalize()
            if let danglingRoot = result.danglingProviders.first {
                rootProvider = .dangling(danglingRoot)
            } else if let referenceRoot = result.referenceProviders.first {
                rootProvider = .reference(referenceRoot)
            }
        }
    }
    
    func finalize() -> (String, RootProvider?) {
        return (seed, rootProvider)
    }
}
