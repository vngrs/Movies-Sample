//
//  URLBuilder.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/4/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

class URLBuilder {

    enum Constants {
        static let cdnBaseUrl = "https://image.tmdb.org/t/p/w"
    }

    static func imageUrl(path: String, width: Int = 500) -> URL? {

        return URL(string: "\(Constants.cdnBaseUrl)\(width)\(path)")
    }
}
