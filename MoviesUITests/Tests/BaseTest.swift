//
//  BaseTest.swift
//  MoviesUITests
//
//  Created by MESUT GUNES on 28.05.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import XCTest

class BaseTest: XCTestCase {
    let basePage = BasePage()
    let app = BasePage().app

    let defaultLoadingTime = 15.0
    let defaultWaitTime = 5.0

    override func setUp() {
        app.launch()
        app.launchArguments = ["enable-testing"]
        continueAfterFailure = false
        
        waitForPageLoading(element: basePage.header)
    }

    override func tearDown() {
        app.terminate()
    }

    func waitForPageLoading(element: XCUIElement) {
        XCTAssertTrue(element.waitForExistence(timeout: defaultLoadingTime))
    }

}
