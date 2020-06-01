//
//  DataSource.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/1/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

protocol DataSource {

    func fetchMovies(page: Int, category: MoviesCategory, completion: @escaping (Result<MoviesResponse>) -> Void )
}

class DataSourceProvider {

    static var globalDataSource = APIClient() // Can be updated in App launch to mock data source
}
