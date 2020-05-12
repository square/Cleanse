//
//  FileVisitor.swift
//  Cleansec
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/**
 Primary parsing object that will walk a source file node and extract any cleanse objects.
 */
struct FileVisitor: SyntaxVisitor {
    var importsCleanse = false
    private var modules: [Module] = []
    private var components: [Component] = []
    
    mutating func visit(node: ImportDecl) {
        if node.raw.matches(#"'Cleanse'"#) {
            importsCleanse = true
        }
    }
    
    mutating func visit(node: StructDecl) {
        visit(inheritableNode: node)
    }
    
    mutating func visit(node: ClassDecl) {
        visit(inheritableNode: node)
    }
    
    mutating func visitChildren(node: StructDecl) -> Bool {
        importsCleanse
    }
    
    mutating func visitChildren(node: ClassDecl) -> Bool {
        importsCleanse
    }
    
    private mutating func visit(inheritableNode: InheritableSyntax) {
        switch inheritableNode.cleanseType {
        case .none:
            break
        case .module:
            guard let moduleName = inheritableNode.raw.firstCapture(#"interface type='(.*)\.Type'"#) else {
                print("Found module. Unable to parse interface type: \(inheritableNode.raw)")
                return
            }
            var bindingsVisitor = BindingsVisitor()
            bindingsVisitor.walk(inheritableNode)
            modules.append(
                bindingsVisitor.finalize().module(type: moduleName)
            )
        case .component:
            guard let componentName = inheritableNode.raw.firstCapture(#"interface type='(.*)\.Type'"#) else {
                print("Found component. Unable to parse interface type: \(inheritableNode.raw)")
                return
            }
            let isRoot = inheritableNode.inherits?.matches("^(Cleanse.)?RootComponent") ?? false
            var bindingsVisitor = BindingsVisitor()
            var componentRootVisitor = ComponentRootProviderVisitor()
            bindingsVisitor.walk(inheritableNode)
            componentRootVisitor.walk(inheritableNode)
            let (seed, rootProvider) = componentRootVisitor.finalize()
            guard let root = rootProvider else {
                print("Unable to discern root provider for component \(componentName). Not creating component for: \(inheritableNode.raw)")
                return
            }
            switch root {
            case .dangling(let dangling):
                components.append(
                    bindingsVisitor.finalize().component(
                        type: componentName,
                        isRoot: isRoot,
                        rootType: dangling.type,
                        seed: seed,
                        additionalProviders: [dangling.standardProvider])
                )
            case .reference(let reference):
                components.append(
                    bindingsVisitor.finalize().component(
                        type: componentName,
                        isRoot: isRoot,
                        rootType: reference.type,
                        seed: seed,
                        additionalProviders: []
                    )
                )
            }
        }
    }
    
    func finalize() -> FileRepresentation {
        FileRepresentation(
            components: components,
            modules: modules
        )
    }
}

fileprivate extension InheritableSyntax {
    var cleanseType: CleanseTypeVisitor.CleanseType {
        var typeVisitor = CleanseTypeVisitor()
        typeVisitor.walkChildren(self)
        return typeVisitor.finalize()
    }
}

fileprivate extension DanglingProvider {
    var standardProvider: StandardProvider {
        return StandardProvider(
            type: type,
            dependencies: dependencies,
            tag: nil,
            scoped: nil,
            collectionType: nil)
    }
}

fileprivate extension BindingsResult {
    func module(type: String) -> Module {
        return Module(
            type: type,
            providers: standardProviders,
            danglingProviders: danglingProviders,
            referenceProviders: referenceProviders,
            includedModules: includedModules,
            subcomponents: installedSubcomponents
        )
    }
    
    func component(type: String, isRoot: Bool, rootType: String, seed: String, additionalProviders: [StandardProvider]) -> Component {
        return Component(
            type: type,
            rootType: rootType,
            providers: standardProviders + additionalProviders,
            danglingProviders: danglingProviders,
            referenceProviders: referenceProviders,
            seed: seed,
            includedModules: includedModules,
            subcomponents: installedSubcomponents,
            isRoot: isRoot
        )
    }
    
}
