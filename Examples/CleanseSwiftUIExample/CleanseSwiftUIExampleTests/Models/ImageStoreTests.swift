//
//  ImageStoreTests.swift
//  CleanseSwiftUIExampleTests
//
//  Created by Abdul Chathil on 1/2/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import XCTest
@testable import CleanseSwiftUIExample

class ImageStoreTests: XCTestCase {

    func testLoadImage() throws {
        let image = ImageStore.loadImage(name: "cat-crawler")
        XCTAssert(image.width == 399)
        XCTAssert(image.height == 391)
    }

}
