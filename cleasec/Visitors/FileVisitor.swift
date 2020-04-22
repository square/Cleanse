//
//  FileVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

public struct FileVisitor: SyntaxVisitor {
    var importsCleanse: Bool = false
    mutating public func visit(node: ImportDecl) {
        if node.raw.contains("Cleanse") {
            importsCleanse = true
        }
    }
    
    mutating public func visit(node: StructDecl) {
        visitModule(node)
    }
    
    mutating public func visit(node: ClassDecl) {
        visitModule(node)
    }
    
    private func visitModule(_ node: InheritableSyntax) {
        guard let inherits = node.inherits, inherits.contains(pattern: "(Cleanse.)?Module") else {
            return
        }
//        var moduleVisitor = ModuleVisitor(name: <#String#>)
//        moduleVisitor.walk(node)
    }
    
}
