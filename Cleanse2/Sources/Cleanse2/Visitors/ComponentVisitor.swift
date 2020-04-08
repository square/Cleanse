//
//  ComponentVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

struct ComponentResults {
    let modules: [String]
    let parent: String?
    let root: NormalizedTypeSyntax
}

struct ComponentVisitor: SyntaxVisitor {
    private var modules: [String] = []
    private var parent: String? = nil
    private var rootType: NormalizedTypeSyntax? = nil
    
    enum DefinedVarTypes: String, CaseIterable {
        case modules = "modules"
        case subcomponents = "parent"
        case unknown
    }
    
    mutating func visitPost(_ node: VariableDeclSyntax) {
        let matchedType = DefinedVarTypes.allCases.first { (type) -> Bool in
            node.matchesSingularBinding(regex: type.rawValue)
        } ?? .unknown
        switch matchedType {
        case .modules:
            let moduleNames = NormalizedTypeSyntax(syntax: node.bindings).text.captureMatches(regex: "(\\w*).self")
            modules += moduleNames
        case .subcomponents:
            let parent = NormalizedTypeSyntax(syntax: node.bindings).text.captureFirst(regex: "(\\w*).self")
            self.parent = parent
        case .unknown:
            break
        }
    }
    
    mutating func visitPost(_ node: TypealiasDeclSyntax) {
        guard node.identifier.text == "Root", let initialzer = node.initializer else {
            return
        }
        
        // TODO: Maybe some validations around duplicate Roots? Should not get here though cause of syntax errors? But think about how this could run first thus causing this to error before the actual syntax error?
        rootType = NormalizedTypeSyntax(syntax: initialzer.value)
    }
    
    func finalize() -> ComponentResults {
        guard let root = rootType else {
            fatalError()
        }
        return ComponentResults(
            modules: modules,
            parent: parent,
            root: root
        )
    }
}

extension VariableDeclSyntax {
    func matchesSingularBinding(regex: String) -> Bool {
        guard bindings.count == 1 else {
            return false
        }
        var iterator = bindings.makeIterator()
        let firstBinding = iterator.next()!
        return NormalizedTypeSyntax(syntax: firstBinding).text.matches(regex: regex)
    }
}
