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

    lazy var firstMovieName = app.tables["moviesTableView"].cells.element(boundBy: 1).staticTexts["movieListTitleLabel"]
    lazy var firstMovieDate = app.tables["moviesTableView"].cells.element(boundBy: 1).staticTexts["movieListReleaseDateLabel"]
    lazy var firstMoviePoint = app.tables["moviesTableView"].cells.element(boundBy: 1).staticTexts["movieListRateLabel"]

    func moviesLoaded() -> Bool {
        
        if !firstMovieName.label.isEmpty &&
            !firstMovieDate.label.isEmpty &&
            !firstMoviePoint.label.isEmpty {

            print("firstMovieName", firstMovieName)
            print("firstMovieDate", firstMovieDate)
            print("firstMovieRate", firstMoviePoint)
            return true
        } else {
            return false
        }
    }


}
