import Foundation
import swift_ast_parser
@testable import cleasec
import XCTest

class ConfigureVisitorTests: XCTestCase {
    var moduleVisitor = ConfigureVisitor()
    
    func testNormalBinding() {
        let input = InputSanitizer.split(text: ModuleFixtures.simpleModuleBinding)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
    }
    
    func testModuleWithBindingDependencies() {
        let input = InputSanitizer.split(text: ModuleFixtures.moduleBindingWith3Dependenices)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["Int", "Character", "Float"])
    }
    
    func testModuleWithImplicitFactory() {
        let input = InputSanitizer.split(text: ModuleFixtures.implicitModuleBinding)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["String", "Int"])
    }
    
    func testModuleWithTaggedAndScopedProvider() {
        let input = InputSanitizer.split(text: ModuleFixtures.moduleWithScopedAndTaggedProvider)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
        XCTAssertEqual(moduleVisitor.providers.first!.tag, "MyTag")
        XCTAssertEqual(moduleVisitor.providers.first!.scoped, "Singleton")
    }
    
    func testModuleWithImplicitType() {
        let input = InputSanitizer.split(text: ModuleFixtures.implicitTypeBinding)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 1)
        XCTAssertEqual(moduleVisitor.providers.first!.type, "A")
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
    }
    
    func testModuleInclude() {
        let input = InputSanitizer.split(text: ModuleFixtures.moduleIncludeFixture)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.includedModules.count, 1)
        XCTAssertEqual(moduleVisitor.includedModules, ["AnotherModuke"])
    }
    
    func testInstallSubcomponent() {
        let input = InputSanitizer.split(text: ModuleFixtures.subcomponentInstallFixture)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.subcomponents.count, 1)
        XCTAssertEqual(moduleVisitor.subcomponents, ["Subcomponent"])
    }
}
