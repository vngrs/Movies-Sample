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
        case debug
        case failed(error: String)
    }

    var movies: [Movie] = []
    var page = 1
    var totalPages: Int = 2
    var isLoading = false
    var category: MoviesCategory = .popular
    var totalClicked = 0
}

class MoviesListViewModel: StatefulViewModel<MoviesListState.Change> {

    var state = MoviesListState()
    let movieModel: MovieModel

    var seconds = 5 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer: Timer?
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

    init(dataSource: MovieModel = RESTMovieModel()) {

        self.movieModel = dataSource
    }

    func runTimer() {

        guard timer == nil else { return }

        seconds = 5
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }

    @objc func updateTimer() {

        print("seconds", seconds)

        if seconds < 1 {
            timer?.invalidate()
            timer = nil
            isTimerRunning = false
            state.totalClicked = 0
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
        }
    }

    func switchToTab(_ tab: MoviesCategory) {

        guard tab != state.category else {

            if state.category == .popular {

                self.runTimer()

                if isTimerRunning {

                    state.totalClicked += 1
                    print("totalClicked:", state.totalClicked)

                    if state.totalClicked >= 5 {

                        print("Let's go Debug Mode")
                        self.emit(change: .debug)
                        state.totalClicked = 0
                    }
                }
            }
            return
        }

        state.totalClicked = 0
        print("totalClicked:", state.totalClicked)
        state.category = tab
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

        movieModel.getMovies(page: state.page, category: state.category) { [weak self] (result) in

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
