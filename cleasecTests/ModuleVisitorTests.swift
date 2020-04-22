//
//  ModuleVisitorTests.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser
@testable import cleasec
import XCTest

class ModuleVisitorTests: XCTestCase {
    var moduleVisitor = ModuleVisitor(name: "Test")
    
    func testNormalBinding() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.simpleModuleBinding).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
    }
    
    func testModuleWithBindingDependencies() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.moduleBindingWith3Dependenices).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["Int", "Character", "Float"])
    }
    
    func testModuleWithImplicitFactory() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.implicitModuleBinding).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["String", "Int"])
    }
    
    func testModuleWithTaggedAndScopedProvider() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.moduleWithScopedAndTaggedProvider).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
        XCTAssertEqual(moduleVisitor.providers.first!.tag, "MyTag")
        XCTAssertEqual(moduleVisitor.providers.first!.scoped, "Singleton")
    }

}
