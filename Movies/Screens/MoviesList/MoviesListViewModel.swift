//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

enum MoviesTab {

    case playing
    case popular
    case next
    case top
}

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
    var tab: MoviesTab = .popular
}

class MoviesListViewModel: StatefulViewModel<MoviesListState.Change> {

    var state = MoviesListState()

    func switchToTab(_ tab: MoviesTab) {

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
        let request = makeRequest()
        NetworkingManager.shared.start(dataModelRequest: request) { [weak self] (response: Response<MoviesResponse>) in

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

    func makeRequest() -> BaseRequest {

        switch state.tab {
        case .popular:
            return PopularMoviesRequest(page: state.page)
        case .playing:
            return NowPlayingMoviesRequest(page: state.page)
        case .next:
            return UpcomingMoviesRequest(page: state.page)
        case .top:
            return TopRatedMoviesRequest(page: state.page)
        }
    }
}
