import XCTest
import SwiftAstParser
@testable import CleansecFramework

class FileVisitorTests: XCTestCase {
    var visitor: FileVisitor!
    override func setUp() {
        visitor = FileVisitor()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        visitor = nil
    }

    func testImportedCleanse() {
        let node = SyntaxParser.parse(text: Fixtures.ImportsCleanse).first!
        visitor.walk(node)
        XCTAssertTrue(visitor.importsCleanse)
    }
    
    func testNonImportedCleanse() {
        let node = SyntaxParser.parse(text: Fixtures.DoesNotImportCleanse).first!
        visitor.walk(node)
        XCTAssertFalse(visitor.importsCleanse)
    }
    
    func testParsesNormalComponent() {
        let node = SyntaxParser.parse(text: Fixtures.SimpleComponent).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.components.count, 2)
        XCTAssertEqual(result.components.first!.isRoot, false)
        XCTAssertEqual(result.components.first!.rootType, "Int")
        XCTAssertEqual(result.components.first!.providers, [StandardProvider(type: "Int", dependencies: [], tag: nil, scoped: nil, collectionType: nil)])
        
        XCTAssertEqual(result.components[1].type, "Container.NestedSubcomponent")
    }

    func testParsesRootComponent() {
        let node = SyntaxParser.parse(text: Fixtures.SimpleRootComponent).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.components.count, 1)
        XCTAssertEqual(result.components.first!.isRoot, true)
        XCTAssertEqual(result.components.first!.rootType, "Int")
        XCTAssertEqual(result.components.first!.providers, [StandardProvider(type: "Int", dependencies: [], tag: nil, scoped: nil, collectionType: nil)])
    }
    
    func testParsesSeed() {
        let node = SyntaxParser.parse(text: Fixtures.ComponentWithSeed).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.components.count, 1)
        XCTAssertEqual(result.components.first!.seed, "MySeed")
    }

    func testNestedModule() {
        let node = SyntaxParser.parse(text: Fixtures.NestedModule).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.modules.count, 1)
        XCTAssertEqual(result.modules.first!.type, "Blah.Module")
    }
    
    
    func testPropertyInjectorRoot() {
        let node = SyntaxParser.parse(text: Fixtures.PropertyInjectorRoot).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.components.count, 1)
        XCTAssertEqual(result.components.first!.providers, [StandardProvider(type: "PropertyInjector<MainPropertyClass>", dependencies: ["PropertyInjector<MainPropertyClass>"], tag: nil, scoped: nil, collectionType: nil)])
    }

}
