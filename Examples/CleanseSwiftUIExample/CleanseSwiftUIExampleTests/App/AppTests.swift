//
//  AppTests.swift
//  CleanseSwiftUIExampleTests
//
//  Created by Abdul Chathil on 1/2/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import XCTest
@testable import CleanseSwiftUIExample

class AppTests: XCTestCase {

    func testInjectProperties() {
        let app = AdoptmeApp()
        XCTAssert(app.user != nil)
        XCTAssert(app.userData != nil)
    }

}
