//
//  TypedSyntax.swift
//  SwiftAstParser
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

public protocol TypedSyntax: Syntax {
    var type: String { get }
}

extension TypedSyntax {
    public var type: String {
        raw.trimmedLeadingWhitespace.firstCapture(#"(?<!interface\s)type=\'(.*)\'"#)!
    }
}

extension CallExpr: TypedSyntax {}
extension DeclrefExpr: TypedSyntax {}
extension Typealias: TypedSyntax {}
