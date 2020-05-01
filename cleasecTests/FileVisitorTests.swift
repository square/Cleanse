//
//  FileVisitorTests.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import XCTest
import swift_ast_parser
@testable import cleasec

class FileVisitorTests: XCTestCase {
    var visitor: FileVisitor!
    
    override func setUp() {
        visitor = FileVisitor()
    }
    
    func testImportedCleanse() {
        let input = InputSanitizer.split(text: Fixtures.ImportsCleanse)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        visitor.walk(node)
        XCTAssertTrue(visitor.importsCleanse)
    }
    
    func testNonImportedCleanse() {
        let input = InputSanitizer.split(text: Fixtures.DoesNotImportCleanse)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        visitor.walk(node)
        XCTAssertFalse(visitor.importsCleanse)
    }
    
    func testParsesNormalComponent() {
        let input = InputSanitizer.split(text: Fixtures.SimpleComponent)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        visitor.walk(node)
        XCTAssertEqual(visitor.components.count, 1)
        XCTAssertEqual(visitor.components.first!.isRoot, false)
        XCTAssertEqual(visitor.components.first!.rootType, "Int")
        XCTAssertEqual(visitor.components.first!.providers, [StandardProvider(type: "Int", dependencies: [], tag: nil, scoped: nil, collectionType: nil)])
    }
    
    func testParsesRootComponent() {
        let input = InputSanitizer.split(text: Fixtures.SimpleRootComponent)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        visitor.walk(node)
        XCTAssertEqual(visitor.components.count, 1)
        XCTAssertEqual(visitor.components.first!.isRoot, true)
        XCTAssertEqual(visitor.components.first!.rootType, "Int")
        XCTAssertEqual(visitor.components.first!.providers, [StandardProvider(type: "Int", dependencies: [], tag: nil, scoped: nil, collectionType: nil)])
    }
    
    func testNestedModule() {
        let input = InputSanitizer.split(text: Fixtures.NestedModule)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        visitor.walk(node)
        XCTAssertEqual(visitor.modules.count, 1)
        XCTAssertEqual(visitor.modules.first!.type, "Blah.Module")
    }
}
