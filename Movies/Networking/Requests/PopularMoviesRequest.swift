//
//  PopularMoviesRequest.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct PopularMoviesRequest: BaseRequest {

    let path: String = "movie/popular"
    var page: Int = 1

    init(page: Int) {

        self.page = page
    }

    var urlParameters: JSONDictionary? {
        return defaultUrlParams.merging(
        [ "page": page]) {
            (current,_) in current
        }
    }
}
