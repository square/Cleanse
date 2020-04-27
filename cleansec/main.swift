//
//  main.swift
//  cleansec
//
//  Created by Sebastian Edward Shanus on 4/26/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import ArgumentParser
import cleasec

struct CLI: ParsableCommand {
    @Option(name: .long)
    var astDirectory: String
    
    @Option(name: .long, parsing: .singleValue)
    var moduleSearchPath: [String]
    
    @Option(name: .long)
    var moduleOutputDirectory: String
    
    @Option(name: .long)
    var moduleName: String
    
    var cleanseModuleName: String {
        return "\(moduleName).cleansecmodule"
    }
    
    var astFilename: String {
        return "\(moduleName).ast"
    }
    
    var astPath: URL {
        var astPath = URL(fileURLWithPath: astDirectory)
        astPath.appendPathComponent(astFilename)
        return astPath
    }
    
    var moduleOutputPath: URL {
        var moduleOutputPath = URL(fileURLWithPath: moduleOutputDirectory)
        moduleOutputPath.appendPathComponent(cleanseModuleName)
        return moduleOutputPath
    }
    
    func run() throws {
        let astText = try String(contentsOf: astPath)
        let module = Cleansec.analyze(input: astText)
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        let encodedModule = try jsonEncoder.encode(module)
        try encodedModule.write(to: moduleOutputPath)
        
        if !(module.files.flatMap { $0.components }.filter { $0.isRoot }.isEmpty) {
            let loadedModules = try moduleSearchPath
                .flatMap { $0.moduleSearchFiles(current: moduleOutputPath) }
                .map { try Data(contentsOf: $0) }
                .map { try JSONDecoder().decode(ModuleRepresentation.self, from: $0) }
            
            let linkedInterface = Linker.link(modules: [module] + loadedModules)
            let resolvedComponents = linkedInterface
                .components
                .filter { $0.isRoot }
                .map { Resolver.resolve(rootComponent: $0, in: linkedInterface) }
            
            resolvedComponents.forEach { (c) in
                print(c.diagnostics)
            }
        }
    }
}

fileprivate extension String {
    func moduleSearchFiles(current: URL) -> [URL] {
        do {
            let dirContents = try FileManager().contentsOfDirectory(atPath: self)
            return dirContents
                .filter { $0.hasSuffix(".cleansecmodule") }
                .map { file in
                    var url = URL(fileURLWithPath: self)
                    url.appendPathComponent(file)
                    return url
                }
                .filter { $0 != current }
        } catch {
            print("FileManager error: \(error)")
            return []
        }
    }
}

CLI.main()


