//
//  APIClient.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

enum MoviesCategory {

    case playing
    case popular
    case next
    case top
}

class RESTMovieModel: MovieModel {

    func getMovies(page: Int = 1, category: MoviesCategory, completion: @escaping (Result<MoviesResponse>) -> Void ) {

        let request = makeRequest(page: page, category: category)
        NetworkingManager.shared.start(dataModelRequest: request) { (response: Response<MoviesResponse>) in

            completion(response.result)
        }
    }

    private func makeRequest(page: Int, category: MoviesCategory) -> BaseRequest {

        switch category {
        case .popular:
            return PopularMoviesRequest(page: page)
        case .playing:
            return NowPlayingMoviesRequest(page: page)
        case .next:
            return UpcomingMoviesRequest(page: page)
        case .top:
            return TopRatedMoviesRequest(page: page)
        }
    }
}
