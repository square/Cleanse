//
//  ComponentVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 4/7/20.
//

import Foundation
import SwiftSyntax

struct ComponentResults {
    let name: TypedKey
    let modules: [TypedKey]
    let parent: TypedKey?
    let root: TypedKey
}

struct ComponentVisitor: SyntaxVisitor {
    let name: TypedKey
    private var modules: [TypedKey] = []
    private var parent: TypedKey? = nil
    private var rootType: TypedKey? = nil
    init(name: TypedKey) {
        self.name = name
    }
    
    enum DefinedVarTypes: String, CaseIterable {
        case modules = "modules"
        case parent = "parent"
        case unknown
    }
    
    mutating func visitPost(_ node: VariableDeclSyntax) {
        let matchedType = DefinedVarTypes.allCases.first { (type) -> Bool in
            node.matchesSingularBinding(regex: type.rawValue)
        } ?? .unknown
        switch matchedType {
        case .modules:
            let moduleNames = node
                .bindings
                .withoutTrivia()
                .tokens
                .map { $0.text }
                .joined()
                .captureMatches(regex: "(\\w*).self")
                .map { TypedKey(syntax: SyntaxFactory.makeTypeIdentifier($0)) }
            modules += moduleNames
        case .parent:
            let parent = node.bindings.withoutTrivia().tokens.map { $0.text }.joined().captureFirst(regex: "(\\w*).self")
            self.parent = TypedKey(syntax: SyntaxFactory.makeTypeIdentifier(parent))
        case .unknown:
            break
        }
    }
    
    mutating func visitPost(_ node: TypealiasDeclSyntax) {
        guard node.identifier.text == "Root", let initialzer = node.initializer else {
            return
        }
        
        // TODO: Maybe some validations around duplicate Roots? Should not get here though cause of syntax errors? But think about how this could run first thus causing this to error before the actual syntax error?
        rootType = TypedKey(syntax: initialzer.value)
    }
    
    func finalize() -> ComponentResults {
        guard let root = rootType else {
            fatalError()
        }
        return ComponentResults(
            name: name,
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
        return firstBinding.tokens.map { $0.text }.joined().matches(regex: regex)
    }
}
