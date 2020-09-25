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
    func testLinking() {
        let componentA = Component(
            type: "MyComponent",
            rootType: "Int",
            providers: [
                StandardProvider(type: "Int", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
            ],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let componentB = Component(
            type: "SecondComponent",
            rootType: "Float",
            providers: [
                StandardProvider(type: "Float", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
            ],
            seed: "Void",
            includedModules: [],
            subcomponents: [],
            isRoot: true
        )
        let fileA = FileRepresentation(components: [componentA], modules: [])
        let fileB = FileRepresentation(components: [componentB], modules: [])
        let moduleA = ModuleRepresentation(files: [fileA])
        let moduleB = ModuleRepresentation(files: [fileB])
        let interface = Linker.link(modules: [moduleA, moduleB])
        XCTAssertEqual(interface.components.count, 2)
    }
}
