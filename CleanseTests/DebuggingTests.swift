//
//  GraphTests.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/10/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


import XCTest

@testable import Cleanse

class DebuggingTests: XCTestCase {
    
    struct FooModule : Module {
        func configure<B : Binder>(binder binder: B) {
            binder.bind().to(value: 3)
            binder.bind().to(value: "Imma string")
        }
    }
    
    func testGraphDebugDescription() {
        // The graph's description should list providers. This may be useful for deubgging. This test is also to exercise code coverage of description methods
        let g = Graph(scope: Singleton.self)
        
        // TODO: make it more descriptive
        
        g.install(module: FooModule())
        
        try! g.finalize()
        
        let description = g.debugDescription
        
        Assert(description, contains: "Provider<String>")
        Assert(description, contains: "Provider<Int>")
        Assert(description, contains: "Provider<() -> Int>")
        Assert(description, contains: "Provider<() -> String>")
    }
}


func Assert(@autoclosure _ entireString: () throws -> String, @autoclosure contains expectedContents: () throws -> String, file: StaticString = #file, line: UInt = #line) {
    XCTAssertTrue(try entireString().contains(expectedContents()), "Expected \(try! entireString()) to contain \(try! expectedContents())", file: file, line: line)
}