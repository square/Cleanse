//
//  SwiftAstParserTests.swift
//  SwiftAstParserTests
//
//  Created by Sebastian Edward Shanus on 5/7/20.
//  Copyright © 2020 Square. All rights reserved.
//

import XCTest
@testable import SwiftAstParser

class SwiftAstParserTests: XCTestCase {
    func testUnknownNode() {
        let fixture = "    (unknown )"
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 1)
        let isType = result.first as? UnknownSyntax
        XCTAssertNotNil(isType)
    }
    
    func testSoureFileNode() {
        let fixture = "(source_file "
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 1)
        let isType = result.first as? SourceFileDecl
        XCTAssertNotNil(isType)
    }
    
    func testParsesKnownNode() {
        let node = NodeIdentifier.var_decl
        let fixture = "  (\(node.rawValue) "
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 1)
        let isType = result.first as? VarDecl
        XCTAssertNotNil(isType)
    }
    
}
