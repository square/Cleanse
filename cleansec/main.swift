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
    var astFile: String
    
    @Option(name: .long, parsing: .singleValue)
    var moduleSearchPath: [String]
    
    @Option(name: .long)
    var moduleOutputPath: String
    
    func run() throws {
        let astText = try String(contentsOfFile: astFile)
        
        let module = Cleansec.analyze(input: astText)
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        
        let encodedModule = try jsonEncoder.encode(module)
        try encodedModule.write(to: URL(fileURLWithPath: moduleOutputPath))
        
        if !(module.files.flatMap { $0.components }.filter { $0.isRoot }.isEmpty) {
            let loadedModules = try moduleSearchPath
                .flatMap { $0.directoryModuleFiles }
                .map { try Data(contentsOf: URL(string: $0)!) }
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
    var directoryModuleFiles: [String] {
        do {
            let dirContents = try FileManager().contentsOfDirectory(atPath: self)
            return dirContents.filter { $0.hasSuffix(".cleansecmodule") }
        } catch {
            print("FileManager error: \(error)")
            return []
        }
    }
}

CLI.main()


