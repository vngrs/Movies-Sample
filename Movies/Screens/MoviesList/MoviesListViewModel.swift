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
    var page = 1
    var totalPages: Int = 2
    var isLoading = false
}

class MoviesListViewModel: StatefulViewModel<MoviesListState.Change> {

    var state = MoviesListState()

    func loadMoreMovies() {

        guard !state.isLoading,
            state.page < state.totalPages
            else { return }

        emit(change: .loading)
        state.isLoading = true
        print("Loading page: \(state.page)")
        NetworkingManager.shared.start(dataModelRequest: PopularMoviesRequest(page: state.page)) { [weak self] (response: Response<MoviesResponse>) in

            guard let self = self else { return }

            switch response.result {
            case .success(let response):
                self.state.movies += response.results ?? []
                self.emit(change: .loaded)
                self.state.page += 1
                self.state.totalPages = response.total_pages ?? 0
                self.state.isLoading = false
            case .failure(let error):
                self.state.isLoading = false
                self.emit(change: .failed(error: error.localizedDescription))
            }
        }
    }
}
