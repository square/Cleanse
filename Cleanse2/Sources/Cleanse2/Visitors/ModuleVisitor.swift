//
//  ModuleVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import SwiftSyntax


struct ModuleResults {
    let module: TypedKey
    let providersByType: [TypedKey:Provider]
}

struct ModuleVisitor: SyntaxVisitor {
    private let name: TypedKey
    var providersByType: [TypedKey:Provider] = [:]
    init(name: TypedKey) {
        self.name = name
    }
    
    mutating func visitPost(_ node: FunctionDeclSyntax) {
        if let Provider = Provider.make(from: node, in: name) {
            providersByType[Provider.type] = Provider
        }
    }
    
    func finalize() -> ModuleResults {
        ModuleResults(
            module: name,
            providersByType: providersByType
        )
    }
}
