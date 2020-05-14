//
//  Cleansec.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser

/**
 Primary public inteface for pipeline steps.
 */
public struct Cleansec {
    public static func analyze(syntax: [Syntax]) -> ModuleRepresentation {
        let files = syntax.map { s -> FileRepresentation in
            var fileVisitor = FileVisitor()
            fileVisitor.walk(s)
            return fileVisitor.finalize()
        }
        return ModuleRepresentation(files: files)
    }
    
    public static func link(modules: [ModuleRepresentation]) -> LinkedInterface {
        Linker.link(modules: modules)
    }
    
    public static func resolve(interface: LinkedInterface) -> [ResolvedComponent] {
        Resolver.resolve(interface: interface)
    }
}

public struct CleansecError: CustomStringConvertible, Error {
    public let resolutionErrors: [ResolutionError]
    
    public init(resolutionErrors: [ResolutionError]) {
        self.resolutionErrors = resolutionErrors
    }
    
    public var description: String {
        resolutionErrors.map { $0.description }.joined(separator: "\n")
    }
}
