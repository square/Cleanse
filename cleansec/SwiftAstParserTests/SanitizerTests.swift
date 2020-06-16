//
//  SanitizerTests.swift
//  SwiftAstParserTests
//
//  Created by Sebastian Edward Shanus on 5/7/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftAstParser

class SanitizerTests: XCTestCase {
    func testSplitSourceFileLines() {
        let fixture = "(a )(source_file )"
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 1)
    }
    
    func testSplitLines() {
        let fixture = "(source_file)\n(source_file)"
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 2)
    }
    
    func testLineOverflow() {
        let fixture = "(source_file\naaaa"
        let result = SyntaxParser.parse(text: fixture)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.raw, "(source_fileaaaa")
    }
    
    func testDataString() {
        let fixture = "(source_file)\n(source_file)\n(source_file)".data(using: .utf8)!
        let result = SyntaxParser.parse(data: fixture)
        XCTAssertEqual(result.count, 3)
    }
    
    // Temporarily disabled. Worth investigating better handling of bad data.
    func DISABLED_testUnknownData() {
        let fixture = Data(repeating: 8, count: 200)
        let result = SyntaxParser.parse(data: fixture)
        XCTAssertEqual(result.count, 0)
    }
    
    func testValidStarts() {
        let fixtureA = "(source_file )"
        XCTAssertEqual(fixtureA.isValidNewlineStart, true)
        let fixtureB = "(not_source_file )"
        XCTAssertEqual(fixtureB.isValidNewlineStart, false)
        let fixtureC = "(parameter: "
        XCTAssertEqual(fixtureC.isValidNewlineStart, false)
        let fixtureD = "    no_opening"
        XCTAssertEqual(fixtureD.isValidNewlineStart, false)
        let fixtureE = "  (something"
        XCTAssertEqual(fixtureE.isValidNewlineStart, true)
        let fixtureF = "  (something_cool  "
        XCTAssertEqual(fixtureF.isValidNewlineStart, true)
    }
}
