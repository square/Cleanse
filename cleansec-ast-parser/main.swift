//
//  main.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser

func main() {
    
}

struct Provider {
    let type: String
    let dependencies: [String]
}

extension Provider: CustomStringConvertible {
    var description: String {
        return "\(type) -> \(dependencies)"
    }
}

struct ProviderVisitor: SyntaxVisitor {
    var providers: [Provider] = []
    mutating func visit(node: CallExpr) {
        if let type = node.type.firstCapture(pattern: "BindingReceipt<(.*)>") {
            var dependencyVisitor = BindingProviderVisitor(type: type)
            dependencyVisitor.walk(node)
//            providers.append(Provider(type: type, dependencies: dependencyVisitor.dependencies))
        }
    }
}

struct BindingProviderVisitor: SyntaxVisitor {
    enum BoundType {
        case none, dangling, full
    }
    let type: String
    
    var boundType: BoundType = .none
    
    func visit(node: DeclrefExpr) {
        
    }
}

func parse(text: String) {
    let node = NodeSyntaxParser.parse(text: text)
    node.forEach { (n) in
        var visitor = ProviderVisitor()
        visitor.walk(n)
        print(visitor.providers)
    }
}

parse(text: sample_text)
