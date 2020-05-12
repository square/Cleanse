//
//  CleanseTypeVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/**
 Responsible discerning if a syntax node matches a Cleanse type.
 
 By checking its unique implementation details, we don't have to keep a inherited type map.
 For example, creating a sub-protocol inheriting from a Cleanse Module means that we would have to track
 any implementation that conforms to the sub-protocol.
 
 */
struct CleanseTypeVisitor: SyntaxVisitor {
    enum CleanseType {
        case none, module, component
    }
    
    fileprivate enum TypealiasType: String {
        case scope = "Scope"
        case root = "Root"
    }
    fileprivate enum Function: String {
        case configure = "configure(binder:)"
        case configureRoot = "configureRoot(binder:)"
    }
    
    private var seenTypealiases: [TypealiasType] = []
    private var seenFunctions: [Function] = []
    
    mutating func visitChildren(node: StructDecl) -> Bool {
        false
    }
    
    mutating func visitChildren(node: ClassDecl) -> Bool {
        false
    }
    
    mutating func visit(node: Typealias) {
        if let rawType = node.raw.firstCapture(#"\"(\w+)\""#), let type = TypealiasType(rawValue: rawType) {
            seenTypealiases.append(type)
        }
    }
    
    mutating func visit(node: FuncDecl) {
        if let rawType = node.raw.firstCapture(#"\"(.*)\""#), let type = Function(rawValue: rawType) {
            seenFunctions.append(type)
        }
    }
    
    func finalize() -> CleanseType {
        guard seenTypealiases.contains(.scope), seenFunctions.contains(.configure) else {
            return .none
        }
        
        if seenTypealiases.contains(.root) && seenFunctions.contains(.configureRoot) {
            return .component
        } else {
            return .module
        }
    }
}
