//
//  MovieDetailsRouter.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

protocol MovieDetailsRouter: Router {

    static func routeToMovieDetail(
        from context: BaseViewController,
        movie: Movie
    )
}

extension MovieDetailsRouter {

    static func routeToMovieDetail(
        from context: BaseViewController,
        movie: Movie
    ) {

        let controller = MovieDetailsViewController.instantiate()
        controller.viewModel = MovieDetailsViewModel(movie: movie)
        push(controller, from: context, animated: true)
    }
}

extension AppRouter: MovieDetailsRouter {}
