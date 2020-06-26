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

    lazy var popular = app.buttons["MoviesListViewController.popularButton"]
    lazy var playing = app.buttons["MoviesListViewController.playingButton"]
    lazy var upcoming = app.buttons["MoviesListViewController.nextButton"]
    lazy var top = app.buttons["MoviesListViewController.topButton"]

    lazy var firstMovieName = app.staticTexts["MovieTableViewCell.titleLabel"].firstMatch
    lazy var firstMovieDate = app.staticTexts["MovieTableViewCell.releaseDate"].firstMatch
    lazy var firstMoviePoint = app.staticTexts["MovieTableViewCell.rateLabel"].firstMatch

    func moviesLoaded() -> Bool {
        if !firstMovieName.label.isEmpty &&
            !firstMovieDate.label.isEmpty &&
            !firstMoviePoint.label.isEmpty {

            print("firstMovieName", firstMovieName.label)
            print("firstMovieDate", firstMovieDate.label)
            print("firstMovieRate", firstMoviePoint.label)
            return true
        } else {
            return false
        }
    }


}
