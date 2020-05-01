import Foundation
import swift_ast_parser
@testable import cleasec
import XCTest

class ConfigureVisitorTests: XCTestCase {
    var moduleVisitor = ConfigureVisitor()
    
    func testModuleWithBindingDependencies() {
        let input = InputSanitizer.split(text: Fixtures.ModuleWithDependencies)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 2)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["Int", "Character", "Float"])
        XCTAssert(moduleVisitor.providers[1].dependencies == [])
    }
    
    func testModuleWithImplicitFactory() {
        let input = InputSanitizer.split(text: Fixtures.ModuleWithImplicitInitFactory)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssert(moduleVisitor.providers.first!.dependencies == ["String", "Int"])
    }
    
    func testModuleWithTaggedAndScopedProvider() {
        let input = InputSanitizer.split(text: Fixtures.ModuleWithTaggedProvider)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssert(moduleVisitor.providers.count == 1)
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
        XCTAssertEqual(moduleVisitor.providers.first!.tag, "MyTag")
        XCTAssertEqual(moduleVisitor.providers.first!.scoped, "Singleton")
    }
    
    func testModuleWithImplicitType() {
        let input = InputSanitizer.split(text: Fixtures.ModuleWithImplicitType)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 1)
        XCTAssertEqual(moduleVisitor.providers.first!.type, "A")
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
    }
    
    func testModuleInclude() {
        let input = InputSanitizer.split(text: Fixtures.ModuleIncludesModule)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.includedModules.count, 1)
        XCTAssertEqual(moduleVisitor.includedModules, ["AnotherModule"])
    }
    
    func testInstallSubcomponent() {
        let input = InputSanitizer.split(text: Fixtures.ModuleIncludesSubcomponent)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.subcomponents.count, 1)
        XCTAssertEqual(moduleVisitor.subcomponents, ["Subcomponent"])
    }
}
