//
//  DataSource.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/1/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

protocol MovieModel {

    func getMovies(page: Int, category: MoviesCategory, completion: @escaping (Result<MoviesResponse>) -> Void )
}
