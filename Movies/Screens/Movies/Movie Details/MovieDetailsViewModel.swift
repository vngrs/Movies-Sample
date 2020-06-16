//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct MovieDetailsState {

    enum Change: StateChange {

    }

    let movie: Movie
}

class MovieDetailsViewModel: StatefulViewModel<MovieDetailsState.Change> {

    var state: MovieDetailsState

    init(movie: Movie) {
        state = MovieDetailsState(movie: movie)
    }
}
