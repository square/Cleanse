//
//  Syntax.swift
//  cleansec-ast-parser
//
//  Created by Sebastian Edward Shanus on 4/20/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

public protocol Syntax {
    var raw: String { get }
    var children: [Syntax] { get }
}

public protocol InheritableSyntax: Syntax {
    var inherits: String? { get }
}

public protocol TypedSyntax: Syntax {
    var type: String { get }
}

public protocol ImplicitlyTypedSyntax: Syntax {
    var implicitType: String { get }
}

public extension InheritableSyntax {
    var inherits: String? {
        raw.trimmedLeadingWhitespace.firstCapture(pattern: #"inherits:\s*(\w+)"#)
    }
}

public extension ImplicitlyTypedSyntax {
    var implicitType: String {
        raw.trimmedLeadingWhitespace.firstCapture(pattern: #"implicit type=\\'(.*)\\'"#)!
    }
}


public extension TypedSyntax {
    var type: String {
        raw.trimmedLeadingWhitespace.firstCapture(pattern: "type=\\'(.*)\\'")!
    }
}
