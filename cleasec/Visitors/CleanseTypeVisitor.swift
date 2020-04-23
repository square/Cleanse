//
//  CleanseTypeVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/23/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

struct CleanseTypeVisitor: SyntaxVisitor {
    enum CleanseType {
        case module, component
    }
    
    enum TypealiasType: String {
        case scope = "Scope"
        case root = "Root"
    }
    
    var typealiasTypes: [TypealiasType] = []
    var functionDecls: [FunctionType] = []
    
    enum FunctionType: String {
        case configure = "configure(binder:)"
        case configureRoot = "configureRoot(binder:)"
        
    }
    
    mutating func visit(node: Typealias) {
        if let rawType = node.raw.firstCapture(pattern: #"\"(\w+)\""#), let type = TypealiasType(rawValue: rawType) {
            typealiasTypes.append(type)
        }
    }
    
    mutating func visit(node: FuncDecl) {
        if let rawType = node.raw.firstCapture(pattern: #"\"(.*)\""#), let type = FunctionType(rawValue: rawType) {
            functionDecls.append(type)
        }
    }
    
    func finalize() -> CleanseType? {
        if typealiasTypes.contains(.scope) {
            if typealiasTypes.contains(.root) {
                // Component
                if verifyComponent() {
                    return .component
                }
                return nil
            } else {
                // Module
                if verifyModule() {
                    return .module
                }
                return nil
            }
        } else {
            return nil
        }
    }
    
    private func verifyModule() -> Bool {
        functionDecls.contains(.configure)
    }
    
    private func verifyComponent() -> Bool {
        functionDecls.contains(.configure) && functionDecls.contains(.configureRoot)
    }
}
