//
//  AppDelegate.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import Firebase
@_exported import CoreVNGRSKit

var appDelegate: AppDelegate? {

    return UIApplication.shared.delegate as? AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    weak var tabbarController: TabBarController?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        LaunchManager.shared.launch(application, launchOptions: launchOptions)

        return true
    }
}
