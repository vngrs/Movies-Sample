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

    lazy var firstMovieName = app.tables["MoviesListViewController.tableView"].cells.element(boundBy: 1).staticTexts["MovieTableViewCell.titleLabel"]
    lazy var firstMovieDate = app.tables["MoviesListViewController.tableView"].cells.element(boundBy: 1).staticTexts["MovieTableViewCell.releaseDate"]
    lazy var firstMoviePoint = app.tables["MoviesListViewController.tableView"].cells.element(boundBy: 1).staticTexts["MovieTableViewCell.rateLabel"]

    func moviesLoaded() -> Bool {
        
        if !firstMovieName.label.isEmpty {
//            &&
//            !firstMovieDate.label.isEmpty &&
//            !firstMoviePoint.label.isEmpty {

            print("firstMovieName", firstMovieName)
//            print("firstMovieDate", firstMovieDate)
//            print("firstMovieRate", firstMoviePoint)
            return true
        } else {
            return false
        }
    }


}
