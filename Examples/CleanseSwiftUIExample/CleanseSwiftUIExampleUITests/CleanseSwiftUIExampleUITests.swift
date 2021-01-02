//
//  CleanseSwiftUIExampleUITests.swift
//  CleanseSwiftUIExampleUITests
//
//  Created by Abdul Chathil on 1/2/21.
//  Copyright © 2021 Abdul Chathil. All rights reserved.
//

import XCTest

class CleanseSwiftUIExampleUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
    }
    
    func testExample() throws {
        let elementsQuery = app.scrollViews.otherElements
        XCTAssertTrue(elementsQuery.staticTexts["Find"].exists)
        elementsQuery.buttons["Doe, Some text that supposed\nto describes something, Account"].tap()
        XCTAssertTrue(elementsQuery.staticTexts["Credits"].exists)
        app.navigationBars["User Detail"].buttons["Back"].tap()
        elementsQuery.buttons["Crawler, Bireuen, Aceh, Cat"].tap()
        XCTAssertTrue(elementsQuery.images["heart.fill"].exists)
        elementsQuery.images["heart.fill"].tap()
        XCTAssertTrue(elementsQuery.images["heart"].exists)
    }
}
