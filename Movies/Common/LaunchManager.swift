//
//  LaunchManager.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import UIKit

enum Constants {

    // TODO read from configuration
    static let apiURL = "https://api.themoviedb.org/3"
}

class LaunchManager {

static let shared = LaunchManager()

private init() {}

func launch(
    _ application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {

        NetworkingManager.shared.setHost(Constants.apiURL)
    }
}
