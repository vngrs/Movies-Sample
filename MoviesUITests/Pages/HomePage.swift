//
//  HomePage.swift
//  MoviesUITests
//
//  Created by MESUT GUNES on 12.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import XCTest

class HomePage: BasePage {
    lazy var popular = app.buttons["Popular"]
    lazy var playing = app.buttons["Playing"]
    lazy var upcoming = app.buttons["Upcoming"]
    lazy var top = app.buttons["Top"]
    lazy var firstMovieName = app.tables.element(boundBy: 0).cells.element(boundBy: 0).children(matching: .staticText).element(boundBy: 1)
    lazy var firstMoviePoint = app.tables.element(boundBy: 0).cells.element(boundBy: 0).children(matching: .staticText).element(boundBy: 1)
    lazy var firstMovieDate = app.tables.element(boundBy: 0).cells.element(boundBy: 0).children(matching: .staticText).element(boundBy: 2)

    func moviesLoaded() -> Bool {
        if !firstMovieName.label.isEmpty &&
            !firstMovieDate.label.isEmpty &&
            !firstMoviePoint.label.isEmpty {
            return true
        } else {
            return false
        }
    }


}
