//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct MoviesListState {

    enum Change: StateChange {

        case loading
        case loaded
        case failed(error: String)
    }

    var movies: [MovieModel] = []
}

class MoviesListViewModel: StatefulViewModel<MoviesListState.Change> {

    var state = MoviesListState()

    func loadMoviesList() {

        emit(change: .loading)
        NetworkingManager.shared.start(dataModelRequest: PopularMoviesRequest()) { [weak self] (response: Response<MoviesResponse>) in

            guard let self = self else { return }

            switch response.result {
            case .success(let response):
                self.state.movies = response.results ?? []
                response.results?.forEach { movie in
                    print(movie.title ?? "Not Found")
                }
                self.emit(change: .loaded)
            case .failure(let error):
                self.emit(change: .failed(error: error.localizedDescription))
            }
        }
    }
}
