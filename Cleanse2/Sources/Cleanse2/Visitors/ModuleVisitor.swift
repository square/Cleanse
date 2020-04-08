//
//  ModuleVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import SwiftSyntax

struct NormalizedTypeSyntax: Hashable {
    let text: String
    init(syntax: Syntax) {
        text = syntax.tokens.map { $0.text }.joined()
    }
}

struct ProviderInfo {
    let type: NormalizedTypeSyntax
    let owningModule: String
    let declSyntax: FunctionDeclSyntax
    
    var dependencies: [NormalizedTypeSyntax] {
        return declSyntax.signature.input.parameterList.compactMap { parameter -> NormalizedTypeSyntax? in
            guard let dependency = parameter.type else {
                return nil
            }
            return NormalizedTypeSyntax(syntax: dependency)
        }
    }
    
    static func make(from function: FunctionDeclSyntax, in module: String) -> ProviderInfo? {
        // Validations
        guard let output = function.signature.output else {
            return nil
        }
        
        let type = NormalizedTypeSyntax(syntax: output.returnType)
        
        return ProviderInfo(type: type, owningModule: module, declSyntax: function)
    }
}

struct ModuleResults {
    let moduleName: String
    let providersByType: [NormalizedTypeSyntax:ProviderInfo]
}

struct ModuleVisitor: SyntaxVisitor {
    private let name: String
    var providersByType: [NormalizedTypeSyntax:ProviderInfo] = [:]
    init(name: String) {
        self.name = name
    }
    
    mutating func visitPost(_ node: FunctionDeclSyntax) {
        if let providerInfo = ProviderInfo.make(from: node, in: name) {
            providersByType[providerInfo.type] = providerInfo
        }
    }
    
    func finalize() -> ModuleResults {
        ModuleResults(
            moduleName: name,
            providersByType: providersByType
        )
    }
}
