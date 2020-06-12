//
//  HomePageTests.swift
//  MoviesUITests
//
//  Created by MESUT GUNES on 12.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import XCTest

class HomePageTests: BaseTest {
    let homePage = HomePage()
    
    override func setUp() {
        super.setUp()
        waitForPageLoading(element: homePage.popular)
    }
    
    func clickMenuButton(element: XCUIElement) {
        element.tap()
        XCTAssertTrue(homePage.firstMovieName.waitForExistence(timeout: defaultWaitTime))
    }
    
    func testButtons() {
        XCTAssertTrue(homePage.popular.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.playing.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.upcoming.waitForExistence(timeout: defaultWaitTime))
        XCTAssertTrue(homePage.top.waitForExistence(timeout: defaultWaitTime))
    }
    
    func testButtonsWorking() {
        // by default popular videos should be loaded
        XCTAssertTrue(homePage.moviesLoaded())
        
        clickMenuButton(element: homePage.playing)
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.upcoming)
        XCTAssertTrue(homePage.moviesLoaded())

        clickMenuButton(element: homePage.top)
        XCTAssertTrue(homePage.moviesLoaded())

        // we should retest the popular button
        clickMenuButton(element: homePage.popular)
        XCTAssertTrue(homePage.moviesLoaded())
    }
}
