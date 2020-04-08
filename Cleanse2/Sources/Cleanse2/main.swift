
import ArgumentParser
import SwiftSyntax
import Foundation


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
        // Analyze step.
        do {
            let analyzer = Analyzer(fileResults: fileResults)
            let analyzerResults = try analyzer.finalize()
            let resolver = Resolver(roots: analyzerResults)
            let resolverResults = try resolver.finalize()
            var generator = Generator(resolvedComponents: resolverResults)
            var stringOutput = ""
            try generator.finalize(write: &stringOutput)
            try stringOutput.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
        } catch {
            print("\(error)")
        }
        
        let root = MyRoot_Factory().build()
        root.helloWorld()
        
    }
}


Cleanse2.main()
