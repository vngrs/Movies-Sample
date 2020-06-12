//
//  BasePage.swift
//  MoviesUITests
//
//  Created by MESUT GUNES on 27.05.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import XCTest


class BasePage {
    let app = XCUIApplication()
    lazy var header = app.navigationBars["Movies"].staticTexts["Movies"]
    
}
