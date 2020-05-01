//
//  ProviderTests.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import swift_ast_parser
@testable import cleasec
import XCTest


class ProviderTests: XCTestCase {
    var configureVisitor = ConfigureVisitor()
    
    func testDanglingProviders() {
        let input = InputSanitizer.split(text: Fixtures.DanglingProvider)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.danglingProviders.count, 2)
    }
    
    func testDanglingAndReferenceConnected() {
        let input = InputSanitizer.split(text: Fixtures.DanglingAndReference)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 0)
        XCTAssertEqual(configureVisitor.danglingProviders.count, 1)
        XCTAssertEqual(configureVisitor.referenceProviders.count, 1)
        XCTAssertEqual(configureVisitor.referenceProviders.first!.reference, configureVisitor.referenceProviders.first!.reference)
    }
    
    func testPropertyInjectorBinding() {
        let input = InputSanitizer.split(text: Fixtures.PropertyInjection)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 1)
        XCTAssertEqual(configureVisitor.providers.first!.type, "PropertyInjector<PropertyClass>")
        XCTAssertEqual(configureVisitor.providers.first!.dependencies, ["Int"])
    }
    
    func testPropertyInjectorRoot() {
        let input = InputSanitizer.split(text: Fixtures.PropertyInjectorRoot)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.danglingProviders.count, 1)
        XCTAssertEqual(configureVisitor.referenceProviders.count, 1)
        XCTAssertEqual(configureVisitor.providers.count, 0)
        XCTAssertEqual(configureVisitor.referenceProviders.first!.reference, configureVisitor.referenceProviders.first!.reference)
    }
    
    func testAssistedFactoryProvider() {
        let input = InputSanitizer.split(text: Fixtures.AssistedInjection)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 1)
        XCTAssertEqual(configureVisitor.providers.first!, StandardProvider(type: "Factory<AssistedSeed>", dependencies: ["String"], tag: nil, scoped: nil, collectionType: nil))
    }
    
    func testTaggedProviderDependency() {
        let input = InputSanitizer.split(text: Fixtures.TaggedProviderDependency)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 1)
        XCTAssertEqual(configureVisitor.providers.first!.dependencies, ["TaggedProvider<MyTag2>"])
    }
    
    func testCollectionBindings() {
        let input = InputSanitizer.split(text: Fixtures.CollectionBindings)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 5)
        XCTAssertEqual(configureVisitor.providers[0].dependencies, ["[Int]"])
        XCTAssertEqual(configureVisitor.providers[1].dependencies, ["[[Int]]"])
        XCTAssertEqual(configureVisitor.providers[2].collectionType, "[Int]")
        XCTAssertEqual(configureVisitor.providers[3].collectionType, "[Int]")
        XCTAssertEqual(configureVisitor.providers[4].collectionType, "[[Int]]")
    }
    
    func testDecoratedReferenceProvider() {
        let input = InputSanitizer.split(text: Fixtures.DecoratedReferenceProvider)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.referenceProviders.count, 2)
        XCTAssertEqual(configureVisitor.referenceProviders.first!.scoped, "Singleton")
        XCTAssertEqual(configureVisitor.referenceProviders[1].tag, "MyTag3")
    }
    
    func testInnerReferenceTag() {
        let input = InputSanitizer.split(text: Fixtures.InnerTag)
        let sanitizedInput = InputSanitizer.sanitize(text: input)
        let node = NodeSyntaxParser.parse(text: sanitizedInput).first!
        configureVisitor.walk(node)
        XCTAssertEqual(configureVisitor.providers.count, 1)
        XCTAssertEqual(configureVisitor.providers.first!.tag, "NSObject.Root")
    }
}
