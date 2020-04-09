//
//  FileVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import SwiftSyntax

struct FileResults {
    let moduleResultsByName: [TypedKey:ModuleResults]
    let componentResultsByName: [TypedKey:ComponentResults]
}

// TODO: Refactor the visitPost functions into 1 shared function.
struct FileVisitor: SyntaxVisitor {
    var importsCleanse = false
    
    var moduleResultsByName: [TypedKey:ModuleResults] = [:]
    var componentResultsByName: [TypedKey:ComponentResults] = [:]
    
    mutating func visitPost(_ node: ImportDeclSyntax) {
        if node.path.contains(where: { (syntax) -> Bool in
            return syntax.name.text == "CleanseCore"
        }) {
            importsCleanse = true
        }
    }
    
    mutating func visitPost(_ node: ClassDeclSyntax) {
        guard importsCleanse else {
            return
        }
        var typeVerifier = TypeVerifier()
        node.walk(&typeVerifier)
        
        let typedName = TypedKey(syntax: SyntaxFactory.makeTypeIdentifier(node.identifier.text))
        switch typeVerifier.cleanseType {
        case .component:
            var componentVisitor = ComponentVisitor(name: typedName)
            node.walk(&componentVisitor)
            componentResultsByName[typedName] = componentVisitor.finalize()
        case .module:
            var moduleVisitor = ModuleVisitor(name: typedName)
            node.walk(&moduleVisitor)
            moduleResultsByName[typedName] = moduleVisitor.finalize()
        case .none:
            break
        }
    }
    
    mutating func visitPost(_ node: StructDeclSyntax) {
        guard importsCleanse else {
            return
        }
        var typeVerifier = TypeVerifier()
        node.walk(&typeVerifier)
        
        let typedName = TypedKey(syntax: SyntaxFactory.makeTypeIdentifier(node.identifier.text))
        switch typeVerifier.cleanseType {
        case .component:
            var componentVisitor = ComponentVisitor(name: typedName)
            node.walk(&componentVisitor)
            componentResultsByName[typedName] = componentVisitor.finalize()
        case .module:
            var moduleVisitor = ModuleVisitor(name: typedName)
            node.walk(&moduleVisitor)
            moduleResultsByName[typedName] = moduleVisitor.finalize()
        case .none:
            break
        }
    }
    
    func finalize() -> FileResults {
        FileResults(
            moduleResultsByName: moduleResultsByName,
            componentResultsByName: componentResultsByName
        )
    }
}


