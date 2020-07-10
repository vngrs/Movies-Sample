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

    enum Constants {

        static let moviesListViewController = "MoviesListViewController"
        static let movieTableViewCell = "MovieTableViewCell"
    }


    lazy var popular = app.buttons["\(Constants.moviesListViewController).popularButton"]
    lazy var playing = app.buttons["\(Constants.moviesListViewController).playingButton"]
    lazy var upcoming = app.buttons["\(Constants.moviesListViewController).nextButton"]
    lazy var top = app.buttons["\(Constants.moviesListViewController).topButton"]

    lazy var firstMovieName = app.staticTexts["\(Constants.movieTableViewCell).titleLabel"].firstMatch
    lazy var firstMovieDate = app.staticTexts["\(Constants.movieTableViewCell).releaseDate"].firstMatch
    lazy var firstMoviePoint = app.staticTexts["\(Constants.movieTableViewCell).rateLabel"].firstMatch

//    lazy var firstMoviePoint = app.staticTexts["\(Constants.movieTableViewCell).rateLabel"].firstMatch

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
