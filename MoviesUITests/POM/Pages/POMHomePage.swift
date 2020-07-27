//
//  POMHomePage.swift
//  MoviesUITests
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

final class POMHomePage: UIElementPage<UIElements> {

    private(set) lazy var moviesTableView = table(.homeTableView)
    private(set) lazy var popularButton = button(.homePopularButton)
    private(set) lazy var playButton = button(.homePlayButton)
    private(set) lazy var upcomingButton = button(.homeUpcomingButton)
    private(set) lazy var topButton = button(.homeTopButton)

    private(set) lazy var firstMovieName = staticText(.movieCellTitle).firstMatch
    private(set) lazy var firstMovieDate = staticText(.movieCellDate).firstMatch
    private(set) lazy var firstMoviePoint = staticText(.movieCellPoints).firstMatch

    init() {
        super.init(root: .homeRoot)
    }

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
