
import ArgumentParser
import SwiftSyntax
import Foundation

/*
 TODOs:
 
 1. Allow duplicate module and providers names that do no intersect in the DAG. Generate suffix UUID on typed key probably.
 
 */


struct Cleanse2: ParsableCommand {
    @Option(name: .shortAndLong, parsing: .upToNextOption, help: "Swift source files to be parsed to build Cleanse DAG.")
    var sourceFiles: [String]
    
    @Option(name: .shortAndLong, parsing: .next, help: "Output file with generated sources.")
    var output: String
    
    func run() throws {
        let files = try sourceFiles.map { try SyntaxParser.parse(URL(fileURLWithPath: $0)) }
        var visitedFiles: [FileVisitor] = []
        var fileResults: [FileResults] = []
        files.forEach { (file) in
            var visitor = FileVisitor()
            file.walk(&visitor)
            visitedFiles.append(visitor)
            fileResults.append(visitor.finalize())
        }
        do {
            let analyzer = Analyzer(fileResults: fileResults)
            let analyzerResults = analyzer.finalize()
            
            let resolver = Resolver(roots: analyzerResults.rootNodes)
            let resolverResults = resolver.finalize()
            
            let allDiagnostics = analyzerResults.diagnostics + resolverResults.diagnostics
            var generator = Generator(resolvedComponents: resolverResults.resolvedComponents, diagnostics: allDiagnostics)
            var stringOutput = ""
            try generator.finalize(write: &stringOutput)
            
            try stringOutput.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
        } catch {
            print("Cleanse compiler error! \(error)")
        }
    }
}


Cleanse2.main()
