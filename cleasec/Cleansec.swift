//
//  Cleansec.swift
//  cleasec
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

public struct Cleansec {
    public static func parse(input: [String]) -> [String] {
        return InputSanitizer.sanitize(text: input)
    }
    
    public static func analyze(input: [String]) -> ModuleRepresentation {
        let nodes = NodeSyntaxParser.parse(text: input)
        return analyze(nodes: nodes)
    }
    
    public static func analyze(nodes: [Syntax]) -> ModuleRepresentation {
        return ModuleRepresentation(
            files: nodes.map { n in
                var fileVisitor = FileVisitor()
                fileVisitor.walk(n)
                return fileVisitor.finalize()
            }
        )
    }
    
    public static func link(modules: [ModuleRepresentation]) -> LinkedInterface {
        Linker.link(files: modules.flatMap { $0.files })
    }
    
    public static func resolve(component: LinkedComponent, in interface: LinkedInterface) -> ResolvedComponent {
        Resolver.resolve(rootComponent: component, in: interface)
    }
}
