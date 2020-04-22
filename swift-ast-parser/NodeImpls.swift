//
//  NodeImpls.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public extension SourceFileDecl {
    var fileName: String {
        return raw.trimmedLeadingWhitespace.firstCapture(pattern: "\"(.*)\"")!
    }
}

public extension ImportDecl {
    var importName: String {
        return raw.trimmedLeadingWhitespace.firstCapture(pattern: "'(.*)'")!
    }
}


extension ClassDecl: InheritableSyntax {}
extension StructDecl: InheritableSyntax {}

extension CallExpr: TypedSyntax {}
extension ConstructorRefCallExpr: TypedSyntax {}
extension Parameter: TypedSyntax {}
extension ParenExpr: TypedSyntax {}
extension TupleExpr: TypedSyntax {}
extension DeclrefExpr: TypedSyntax {}

extension ArgumentShuffleExpr: ImplicitlyTypedSyntax {}
