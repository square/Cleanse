//
//  DataTests.swift
//  CleanseSwiftUIExampleTests
//
//  Created by Abdul Chathil on 1/2/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import XCTest
@testable import CleanseSwiftUIExample

class CleanseSwiftUIExampleTests: XCTestCase {

    func testLoadPets() {
        XCTAssert(petData.count == 10)
    }

}
