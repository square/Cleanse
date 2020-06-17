//
//  main.swift
//  cleansec
//
//  Created by Sebastian Edward Shanus on 5/6/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import ArgumentParser
import SwiftAstParser
import CleansecFramework

struct CLI: ParsableCommand {
    @Option(name: .long, parsing: .singleValue, help: "-dump-ast outfile file(s) to parse.")
    var astFile: [String]
    
    @Option(name: .long, parsing: .next, help: "Output path for generated module representation.")
    var moduleOutputPath: String
    
    @Option(name: .long, parsing: .singleValue, help: "Directory path(s) to search for emitted module representations when resolving graph.")
    var moduleSearchPath: [String]
    
    @Option(name: .long, default: nil, parsing: .next, help: "Plugin binary path to be executed.")
    var plugin: String?
    
    @Option(name: .long, parsing: .next)
    var moduleName: String
    
    @Flag(name: .shortAndLong, help: "Emits a readable format of each root compoment")
    var emitComponents: Bool
    
    var moduleRepresentationFilename: String {
        "\(moduleName).cleansecmodule.json"
    }
    
    var moduleSearchPathFiles: [URL] {
        return moduleSearchPath.flatMap { path -> [URL] in
            do {
                return try FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: path), includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants)
            } catch {
                return []
            }
        }
    }
    
    func run() throws {
        let syntax = try astFile
            .map { try Data(contentsOf: URL(fileURLWithPath: $0)) }
            .map { SyntaxParser.parse(data: $0)}
            .flatMap { $0 }
        
        var pluginModuleRepresentations: [ModuleRepresentation] = []
        if let pluginPath = plugin {
            pluginModuleRepresentations = PluginRunner.run(plugin: pluginPath, astFiles: astFile)
        }
        
        let analyzedModuleRepresentation = Cleansec.analyze(syntax: syntax)
        let moduleRepresentation = ModuleRepresentation(
            files: analyzedModuleRepresentation.files + pluginModuleRepresentations.flatMap { $0.files }
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let moduleOutputUrl = URL(fileURLWithPath: moduleOutputPath).appendingPathComponent(moduleName).appendingPathExtension("cleansecmodule.json")
        let moduleData = try encoder.encode(moduleRepresentation.trimmed)
        if let jsonFormat = String(data: moduleData, encoding: .utf8) {
            try FileManager.default.createDirectory(
                atPath: moduleOutputPath,
                withIntermediateDirectories: true,
                attributes: nil
            )
            try jsonFormat.write(to: moduleOutputUrl, atomically: true, encoding: .utf8)
        }
        
        let containsRoot = moduleRepresentation.files.flatMap { $0.components }.contains { $0.isRoot }
        guard containsRoot else {
            return
        } 
        let availableModules = moduleSearchPathFiles
            .filter { !$0.absoluteString.hasSuffix(moduleRepresentationFilename) }
            .filter { $0.absoluteString.hasSuffix("cleansecmodule.json") }
        let loadedModules = try availableModules
            .map { try Data(contentsOf: $0) }
            .map { try JSONDecoder().decode(ModuleRepresentation.self, from: $0) }
        let linkedInterface = Cleansec.link(modules: loadedModules + [moduleRepresentation])
        let resolvedCompoments = Cleansec.resolve(interface: linkedInterface)
        let errors = resolvedCompoments.flatMap { $0.diagnostics }
        if emitComponents {
            resolvedCompoments.forEach { (c) in
                print("------\n\(c)")
            }
        }
        guard !errors.isEmpty else {
            return
        }
        let stderr = FileHandle.standardError
        let error = CleansecError(resolutionErrors: errors)
        stderr.write(error.description.data(using: .utf8)!)
        throw CLIError()
        
    }
}

fileprivate extension ModuleRepresentation {
    // Removes all files with empty modules and components
    var trimmed: ModuleRepresentation {
        return ModuleRepresentation(files: files.filter { !$0.components.isEmpty || !$0.modules.isEmpty })
    }
}

CLI.main()
