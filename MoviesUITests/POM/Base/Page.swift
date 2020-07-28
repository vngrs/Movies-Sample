//
//  Page.swift
//  MoviesUITests
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import XCTest

class Page {

    let element: XCUIElement
    let app = XCUIApplication()

    init(rootIdentifier: String) {
        self.element = app.otherElements[rootIdentifier]
    }

    init(element: XCUIElement) {
        self.element = element
    }
}
