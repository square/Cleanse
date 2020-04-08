//
//  FileVisitor.swift
//  Cleanse2
//
//  Created by Sebastian Edward Shanus on 3/26/20.
//

import Foundation
import SwiftSyntax

struct FileResults {
    let moduleResultsByName: [String:ModuleResults]
    let componentResultsByName: [String:ComponentResults]
}

struct FileVisitor: SyntaxVisitor {
    // TODO: Fix this
    var importsCleanse = true
    
    var moduleResultsByName: [String:ModuleResults] = [:]
    var componentResultsByName: [String:ComponentResults] = [:]
    
    mutating func visitPost(_ node: ImportDeclSyntax) {
        if node.path.contains(where: { (syntax) -> Bool in
            return syntax.name.text == "Cleanse"
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
        
        let name = node.identifier.text
        switch typeVerifier.cleanseType {
        case .component:
            var componentVisitor = ComponentVisitor()
            node.walk(&componentVisitor)
        case .module:
            var moduleVisitor = ModuleVisitor(name: name)
            node.walk(&moduleVisitor)
            moduleResultsByName[name] = moduleVisitor.finalize()
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
        
        let name = node.identifier.text
        switch typeVerifier.cleanseType {
        case .component:
            var componentVisitor = ComponentVisitor()
            node.walk(&componentVisitor)
            componentResultsByName[name] = componentVisitor.finalize()
        case .module:
            var moduleVisitor = ModuleVisitor(name: name)
            node.walk(&moduleVisitor)
            moduleResultsByName[name] = moduleVisitor.finalize()
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


