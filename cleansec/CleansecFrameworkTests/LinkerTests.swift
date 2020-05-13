//
//  LinkerTests.swift
//  CleansecFrameworkTests
//
//  Created by Sebastian Edward Shanus on 5/12/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import XCTest
@testable import CleansecFramework

class LinkerTests: XCTestCase {
    func testLinkingWithModule() {
        let danglingProvider = DanglingProvider(type: "A", dependencies: [], reference: "reference_id")
        let referenceProvider = ReferenceProvider(type: "A", tag: nil, scoped: nil, collectionType: nil, reference: "reference_id")
        let module = Module(
            type: "Test", providers: [], danglingProviders: [danglingProvider], referenceProviders: [referenceProvider], includedModules: [], subcomponents: [])
        let file = FileRepresentation(
            components: [],
            modules: [module])
        let moduleRep = ModuleRepresentation(
            files: [file]
        )
        let interface = Linker.link(modules: [moduleRep])
        XCTAssertEqual(interface.modules.count, 1)
        XCTAssertEqual(interface.modules.first!.providers.count, 1)
        XCTAssertEqual(interface.modules.first!.providers.first!, StandardProvider(type: "A", dependencies: [], tag: nil, scoped: nil, collectionType: nil))
    }
    
    func testLinkingAcrossModules() {
        let danglingProvider = DanglingProvider(type: "A", dependencies: [], reference: "reference_id")
        let referenceProvider = ReferenceProvider(type: "A", tag: nil, scoped: nil, collectionType: nil, reference: "reference_id")
        let moduleA = Module(
            type: "Test",
            providers: [],
            danglingProviders: [],
            referenceProviders: [referenceProvider],
            includedModules: [],
            subcomponents: []
        )
        let moduleB = Module(
            type: "Test_2",
            providers: [],
            danglingProviders: [danglingProvider],
            referenceProviders: [],
            includedModules: [],
            subcomponents: []
        )
        
        
        let file = FileRepresentation(
            components: [],
            modules: [moduleA, moduleB])
        let moduleRep = ModuleRepresentation(
            files: [file]
        )
        let interface = Linker.link(modules: [moduleRep])
        XCTAssertEqual(interface.modules.count, 2)
        XCTAssertEqual(interface.modules.first!.providers.count, 1)
        XCTAssertEqual(interface.modules[1].providers.count, 0)
    }
    
    func testMissingDangling() {
        let referenceProvider = ReferenceProvider(type: "A", tag: nil, scoped: nil, collectionType: nil, reference: "reference_id")
        let moduleA = Module(
            type: "Test",
            providers: [],
            danglingProviders: [],
            referenceProviders: [referenceProvider],
            includedModules: [],
            subcomponents: []
        )
        
        
        let file = FileRepresentation(
            components: [],
            modules: [moduleA])
        let moduleRep = ModuleRepresentation(
            files: [file]
        )
        let interface = Linker.link(modules: [moduleRep])
        XCTAssertEqual(interface.modules.count, 1)
        XCTAssertEqual(interface.modules.first!.providers.count, 0)
    }
    
    func testOnlyDanging() {
        let danglingProvider = DanglingProvider(type: "A", dependencies: [], reference: "reference_id")
        let moduleA = Module(
            type: "Test",
            providers: [],
            danglingProviders: [danglingProvider],
            referenceProviders: [],
            includedModules: [],
            subcomponents: []
        )
        
        
        let file = FileRepresentation(
            components: [],
            modules: [moduleA])
        let moduleRep = ModuleRepresentation(
            files: [file]
        )
        let interface = Linker.link(modules: [moduleRep])
        XCTAssertEqual(interface.modules.count, 1)
        XCTAssertEqual(interface.modules.first!.providers.count, 0)
    }
    
    func testDuplicateDangling() {
        let danglingProvider = DanglingProvider(type: "A", dependencies: [], reference: "reference_id")
        let referenceProvider = ReferenceProvider(type: "A", tag: nil, scoped: nil, collectionType: nil, reference: "reference_id")
        let moduleA = Module(
            type: "Test",
            providers: [],
            danglingProviders: [danglingProvider, danglingProvider],
            referenceProviders: [referenceProvider],
            includedModules: [],
            subcomponents: []
        )
        
        
        let file = FileRepresentation(
            components: [],
            modules: [moduleA])
        let moduleRep = ModuleRepresentation(
            files: [file]
        )
        let interface = Linker.link(modules: [moduleRep])
        XCTAssertEqual(interface.modules.count, 1)
        XCTAssertEqual(interface.modules.first!.providers.count, 1)
    }
}
