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
    static let liveApiURL = "https://api.themoviedb.org/3"
    static let debugApiURL = "https://api.themoviedb.org/3"

    static let mode = "mode"
//    static let live = "live"
//    static let debug = "debug"
}

enum Modes {

    static let live = "live"
    static let debug = "debug"
}

class LaunchManager {

    static let shared = LaunchManager()
    let defaults = UserDefaults.standard
    var url: String = ""

    private init() {}

    func launch(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        var mode = defaults.string(forKey: Constants.mode)
        print("LaunchManager.Mode", mode ?? "")
        guard mode != nil else { return mode = Modes.live }

        if mode == Modes.live {
            url = Constants.liveApiURL
        } else {
            url = Constants.debugApiURL
        }
        
        NetworkingManager.shared.setHost(url)
    }
}
