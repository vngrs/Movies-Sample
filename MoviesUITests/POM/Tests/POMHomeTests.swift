//
//  POMHomeTests.swift
//  MoviesUITests
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//


import Foundation
import XCTest

class POMHomePageTests: BaseTest {

    let homePage = POMHomePage()

    override func setUp() {
        super.setUp()
        waitForPageLoading(element: homePage.popularButton)
    }

    func clickMenuButton(element: XCUIElement) {
        element.tap()
        XCTAssertTrue(homePage.firstMovieName.waitForExistence(timeout: defaultWaitTime))
    }

    func testButtons() {
        XCTAssertTrue(homePage.popularButton.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.playButton.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.upcomingButton.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.topButton.waitForExistence(timeout: defaultWaitTime))
    }

    func testButtonsWorking() {
        // by default popular videos should be loaded
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.playButton)
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.upcomingButton)
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.topButton)
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.popularButton)
        XCTAssertTrue(homePage.moviesLoaded())
    }
}
