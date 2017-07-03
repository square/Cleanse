//
//  TaggedProviderTests.swift
//  Cleanse
//
//  Created by holmes on 3/21/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Cleanse
import Foundation
import XCTest

fileprivate struct TestTag : Tag {
    typealias Element = Int
}

fileprivate class TagHolder {
    fileprivate var value = 42

    func magicNumber() -> Int {
        return value
    }
}

class TaggedProviderTests: XCTestCase {
    fileprivate var tagHolder: TagHolder!
    fileprivate var taggedProvider: TaggedProvider<TestTag>!

    override func setUp() {
        tagHolder = TagHolder()
        taggedProvider = TaggedProvider(getter: tagHolder.magicNumber)
    }

    func testTaggedProviderProvidesCorrectValue() {
        XCTAssertEqual(42, taggedProvider.get())
    }

    func testAsProviderWorksCorrectly() {
        let provider = taggedProvider.asProvider()

        let tagValue = taggedProvider.get()
        let providerValue = provider.get()
        XCTAssertEqual(tagValue, providerValue)

        tagHolder.value = 1
        XCTAssertEqual(1, taggedProvider.get())
        XCTAssertEqual(provider.get(), taggedProvider.get())
    }
}
