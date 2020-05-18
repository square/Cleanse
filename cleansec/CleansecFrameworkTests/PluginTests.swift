//
//  PluginTests.swift
//  CleansecFrameworkTests
//
//  Created by Sebastian Edward Shanus on 5/18/20.
//  Copyright © 2020 Square. All rights reserved.
//

import Foundation
import XCTest
@testable import CleansecFramework

class PluginTests: XCTestCase {
    func testBadPluginPath() {
        XCTAssertNil(Cleansec.run(plugin: "badecho", astFilePath: "."))
    }
    
    func testPluginOutput() {
        let provider = StandardProvider(type: "String", dependencies: [], tag: nil, scoped: nil, collectionType: nil)
        let module = Module(type: "Module", providers: [provider], danglingProviders: [], referenceProviders: [], includedModules: [], subcomponents: [])
        let file = FileRepresentation(components: [], modules: [module])
        let moduleRepresentation = ModuleRepresentation(files: [file])
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(moduleRepresentation)
        let outputString = String(data: data, encoding: .utf8)!
        
        let pluginOutput = Cleansec.run(plugin: "/bin/echo", astFilePath: outputString)
        XCTAssertNotNil(pluginOutput)
        XCTAssertNotNil(pluginOutput?.files.first?.modules.first)
        XCTAssertEqual(pluginOutput?.files.first?.modules.first?.providers.first, provider)
    }
    
    func testPluginBadOutput() {
        let pluginOutput = Cleansec.run(plugin: "/bin/echo", astFilePath: "{\"something\": \"else\"}")
        XCTAssertNil(pluginOutput)
    }
}
