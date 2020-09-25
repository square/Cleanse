import XCTest
import SwiftAstParser
@testable import CleansecFramework


class BindingsVisitorTests: XCTestCase {
    var visitor: BindingsVisitor!
    override func setUp() {
        visitor = BindingsVisitor()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        visitor = nil
    }
    
    func testModuleWithBindingDependencies() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleWithDependencies).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssert(result.standardProviders.count == 2)
        XCTAssert(result.standardProviders.first!.dependencies == ["Int", "Character", "Float"])
        XCTAssert(result.standardProviders[1].dependencies == [])
    }

    func testModuleWithImplicitFactory() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleWithImplicitInitFactory).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssert(result.standardProviders.count == 1)
        XCTAssert(result.standardProviders.first!.dependencies == ["String", "Int"])
    }

    func testModuleWithTaggedAndScopedProvider() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleWithTaggedProvider).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssert(result.standardProviders.count == 1)
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["String", "Int"])
        XCTAssertEqual(result.standardProviders.first!.tag, "MyTag")
        XCTAssertEqual(result.standardProviders.first!.scoped, "Singleton")
    }

    func testModuleWithImplicitType() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleWithImplicitType).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.type, "A")
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["String", "Int"])
    }

    func testModuleInclude() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleIncludesModule).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 0)
        XCTAssertEqual(result.includedModules, ["AnotherModule"])
    }

    func testInstallSubcomponent() {
        let node = SyntaxParser.parse(text: Fixtures.ModuleIncludesSubcomponent).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 0)
        XCTAssertEqual(result.installedSubcomponents, ["Subcomponent"])
    }
    

    func testPropertyInjectorBinding() {
        let node = SyntaxParser.parse(text: Fixtures.PropertyInjection).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.type, "PropertyInjector<PropertyClass>")
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["Int"])
    }

    func testAssistedFactoryProvider() {
        let node = SyntaxParser.parse(text: Fixtures.AssistedInjection).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.type, "Factory<AssistedSeed>")
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["String"])
        XCTAssertNil(result.standardProviders.first!.tag)
        XCTAssertNil(result.standardProviders.first!.scoped)
        XCTAssertNil(result.standardProviders.first!.collectionType)
    }

    func testTaggedProviderDependency() {
        let node = SyntaxParser.parse(text: Fixtures.TaggedProviderDependency).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["TaggedProvider<MyTag2>"])
    }

    func testCollectionBindings() {
        let node = SyntaxParser.parse(text: Fixtures.CollectionBindings).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 5)
        XCTAssertEqual(result.standardProviders[0].dependencies, ["[Int]"])
        XCTAssertEqual(result.standardProviders[1].dependencies, ["[[Int]]"])
        XCTAssertEqual(result.standardProviders[2].collectionType, "[Int]")
        XCTAssertEqual(result.standardProviders[3].collectionType, "[Int]")
        XCTAssertEqual(result.standardProviders[4].collectionType, "[[Int]]")
    }

    func testInnerReferenceTag() {
        let node = SyntaxParser.parse(text: Fixtures.InnerTag).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.tag, "NSObject.Root")
    }

    func testGenericType() {
        let node = SyntaxParser.parse(text: Fixtures.GenericType).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.type, "GenericType<String>")
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["String"])
    }
    
    func testLargeDependenicesCount() {
         let node = SyntaxParser.parse(text: Fixtures.ManyDependencies).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.first!.dependencies.count, 10)
    }
    
    func testDebugData() {
         let node = SyntaxParser.parse(text: Fixtures.ModuleWithDependencies).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertNotNil(result.standardProviders.first!.debugData.location)
        XCTAssertTrue(result.standardProviders.first!.debugData.location!.hasSuffix("ModuleWithDependencies.swift:16:10"))
    }
    
    func testImplicitProviderDependency() {
        let node = SyntaxParser.parse(text: Fixtures.BasicBindings).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 1)
        XCTAssertEqual(result.standardProviders.first!.dependencies, ["() -> Float", "() -> Bool", "() -> Float"])
    }
    
    func testBindingsWithCustomScope() {
        let node = SyntaxParser.parse(text: Fixtures.CustomScopeBinding).first!
        visitor.walk(node)
        let result = visitor.finalize()
        XCTAssertEqual(result.standardProviders.count, 2)
    }
}
