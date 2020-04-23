import Foundation
import swift_ast_parser
@testable import cleasec
import XCTest

class ConfigureVisitorTests: XCTestCase {
    var moduleVisitor = ConfigureVisitor()
    
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
    
    func testModuleWithImplicitType() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.implicitTypeBinding).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 1)
        XCTAssertEqual(moduleVisitor.providers.first!.type, "A")
        XCTAssertEqual(moduleVisitor.providers.first!.dependencies, ["String", "Int"])
    }
    
    func testModuleInclude() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.moduleIncludeFixture).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.includedModules.count, 1)
        XCTAssertEqual(moduleVisitor.includedModules, ["AnotherModuke"])
    }
    
    func testInstallSubcomponent() {
        let node = NodeSyntaxParser.parse(text: ModuleFixtures.subcomponentInstallFixture).first!
        moduleVisitor.walk(node)
        XCTAssertEqual(moduleVisitor.providers.count, 0)
        XCTAssertEqual(moduleVisitor.subcomponents.count, 1)
        XCTAssertEqual(moduleVisitor.subcomponents, ["Subcomponent"])
    }
}
