//
//  Movie.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Codable {

    let title: String?
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
    var voteColor: UIColor {
        guard let average = vote_average else {
            return .gray
        }

        if average <= 3 { return .red }
        if average <= 5 { return .orange }
        if average <= 6.5 { return .yellow }
        return .green
    }
}
