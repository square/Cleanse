//
//  FileVisitor.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

struct FileRepresentation {
    let components: [Component]
    let modules: [Module]
}

public struct FileVisitor: SyntaxVisitor {
    var importsCleanse: Bool = false
    var modules: [Module] = []
    var components: [Component] = []
    
    mutating public func visit(node: ImportDecl) {
        if node.raw.contains("Cleanse") {
            importsCleanse = true
        }
    }
    
    mutating public func visit(node: StructDecl) {
        if let moduleName = isModule(node) {
            visitModule(node, moduleName: moduleName)
        }
        if let componentType = isComponent(node) {
            let componentName: String
            let isRoot: Bool
            switch componentType {
            case .component(let name):
                componentName = name
                isRoot = false
            case .root(let name):
                componentName = name
                isRoot = true
            }
            visitComponent(node, componentName: componentName, isRoot: isRoot)
        }
    }
    
    mutating public func visit(node: ClassDecl) {
        if let moduleName = isModule(node) {
            visitModule(node, moduleName: moduleName)
        }
        if let componentType = isComponent(node) {
            let componentName: String
            let isRoot: Bool
            switch componentType {
            case .component(let name):
                componentName = name
                isRoot = false
            case .root(let name):
                componentName = name
                isRoot = true
            }
            visitComponent(node, componentName: componentName, isRoot: isRoot)
        }
    }
    
    private mutating func visitComponent(_ node: InheritableSyntax, componentName: String, isRoot: Bool) {
        var componentVisitor = ComponentVisitor()
        var configVisitor = ConfigureVisitor()
        componentVisitor.walk(node)
        configVisitor.walk(node)
        components.append(Component(
            providers: configVisitor.providers,
            seed: componentVisitor.seed,
            modules: configVisitor.includedModules,
            subcomponents: configVisitor.subcomponents,
            isRoot: isRoot)
        )
    }
    
    private mutating func visitModule(_ node: InheritableSyntax, moduleName: String) {
        var configureVisitor = ConfigureVisitor()
        configureVisitor.walk(node)
        modules.append(Module(
            type: moduleName,
            providers: configureVisitor.providers,
            includedModules: configureVisitor.includedModules,
            subcomponents: configureVisitor.subcomponents)
        )
    }
    
    private func isModule(_ node: InheritableSyntax) -> String? {
        guard let inherits = node.inherits, inherits.contains(pattern: "(Cleanse.)?Module")
            , let moduleName = node.raw.firstCapture(pattern: #"\"(\w+)\""#) else {
            return nil
        }
        return moduleName
    }
    
    private enum ComponentType {
        case component(String)
        case root(String)
    }
    
    private func isComponent(_ node: InheritableSyntax) -> ComponentType? {
        guard let inherits = node.inherits, let componentName = node.raw.firstCapture(pattern: #"\"(\w+)\""#) else {
            return nil
        }
        if inherits.contains(pattern: "(Cleanse.)?RootComponent") {
            return .root(componentName)
        } else if inherits.contains(pattern: "(Cleanse.)?Component") {
            return .component(componentName)
        } else {
            return nil
        }
    }
}

extension FileVisitor {
    func finalize() -> FileRepresentation {
        return FileRepresentation(
            components: components,
            modules: modules
        )
    }
}
