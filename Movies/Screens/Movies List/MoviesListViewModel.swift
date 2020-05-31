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

    var movies: [Movie] = []
    var page = 1
    var totalPages: Int = 2
    var isLoading = false
    var tab: MoviesCategory = .popular
}

class MoviesListViewModel: StatefulViewModel<MoviesListState.Change> {

    var state = MoviesListState()

    func switchToTab(_ tab: MoviesCategory) {

        guard tab != state.tab else { return }

        state.tab = tab
        state.page = 1
        state.isLoading = false
        state.movies = []
        loadMoreMovies()
    }

    func loadMoreMovies() {

        guard !state.isLoading,
            state.page < state.totalPages
            else { return }

        emit(change: .loading)
        state.isLoading = true

        APIClient.fetchMovies(page: state.page, category: state.tab) { [weak self] (result) in

            guard let self = self else { return }

            switch result {
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
