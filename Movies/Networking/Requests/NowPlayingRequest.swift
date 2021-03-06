//
//  NowPlayingRequest.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/4/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct NowPlayingMoviesRequest: BaseRequest {

    let path: String = "movie/now_playing"
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
