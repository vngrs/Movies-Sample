//
//  MoviesListPresentation.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct MoviesListPresentation: Presentation {

    var cellsPresentations: [MovieCellPresentation] = []

    mutating func update(with state: MoviesListState) {

        cellsPresentations = state.movies.map({
            return MovieCellPresentation(
                title: $0.title ?? "",
                releaseDate: $0.release_date,
                bannerUrl: URLBuilder.imageUrl(path: $0.poster_path ?? ""),
                rating: "\($0.vote_average ?? 0)",
                ratingColor: $0.voteColor
            )
        })
    }
}
