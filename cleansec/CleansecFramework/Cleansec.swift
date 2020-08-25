//
//  Cleansec.swift
//  CleansecFramework
//
//  Created by Sebastian Edward Shanus on 5/13/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import SwiftAstParser
import os.log

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
    
    public static func run(plugin path: String, astFilePath: String) -> ModuleRepresentation? {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: path)
        process.arguments = [astFilePath]
        let output = Pipe()
        process.standardOutput = output
        
        do {
            try process.run()
        } catch {
            os_log("Plugin process failed: %@", type: .debug, String(describing: error))
            return nil
        }
        let data = output.fileHandleForReading.readDataToEndOfFile()
        do {
            return try JSONDecoder().decode(ModuleRepresentation.self, from: data)
        } catch {
            os_log("Failed to parse plugin output to `ModuleRepresentation`. Make sure you using JSONDecoder over a `ModuleRepresentation` instance.", type: .info)
            return nil
        }
    }
}

public struct CleansecError: CustomStringConvertible, Error {
    public let resolutionErrors: [ResolutionError]
    
    public init(resolutionErrors: [ResolutionError]) {
        self.resolutionErrors = resolutionErrors
    }
    
    public var description: String {
        resolutionErrors.map { $0.description }.joined(separator: "\n") + "\n"
    }
}

public struct CLIError: CustomStringConvertible, Error {
    public init() {}
    public var description: String {
        "cleansec failed"
    }
}
