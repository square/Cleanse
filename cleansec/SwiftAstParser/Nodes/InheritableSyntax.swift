//
//  InheritableSyntax.swift
//  SwiftAstParser
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation

/// Syntax node types that can have an inherited type.
public protocol InheritableSyntax: Syntax {
    var inherits: String? { get }
}

extension InheritableSyntax {
    public var inherits: String? {
        raw.trimmedLeadingWhitespace.firstCapture(#"inherits:\s*(\w+)"#)
    }
}

extension ClassDecl: InheritableSyntax {}
extension StructDecl: InheritableSyntax {}
