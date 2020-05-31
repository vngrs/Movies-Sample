//
//  MoviesResponse.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct MoviesResponse: CodableResponse {

    let page: Int?
    let total_pages: Int?
    let results: [Movie]?
}
