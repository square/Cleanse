//
//  ComponentRootVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/**
 Responsible for extracting out the root provider instance and seed type for a given component body.
 */
public struct ComponentRootVisitor: SyntaxVisitor {
    public init() {}
    
    private var seed = "Void"
    private var rootProvider: DanglingProvider?
    
    public mutating func visit(node: Typealias) {
        if node.raw.contains("\"Seed\"") {
            if let type = node.type.firstCapture(#"(.*)"#), type != "Void" {
                seed = type
            }
        }
    }
    
    public mutating func visit(node: FuncDecl) {
        if node.raw.contains("configureRoot(binder:)") {
            var rootProviderVisitor = RootProviderVisitor()
            rootProviderVisitor.walk(node)
            if let danglingRoot = rootProviderVisitor.finalize() {
                rootProvider = danglingRoot
            }
        }
    }
    
    public func finalize() -> (String, DanglingProvider?) {
        return (seed, rootProvider)
    }
}
