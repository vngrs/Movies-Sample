//
//  AppDelegate.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Option 1: Update translations in the background and show
        //           them on the next app launch.
//        OTATranslations.shared.updateTranslations()


        // Option 2: Reload the app UI immediately after new translations
        //           are downloaded
        OTATranslations.shared.updateTranslations() {
            AppDelegate.reloadRootViewController()
        }


        // ⚠️☝🏽 Careful with reloading the root view controller (Option 2),
        // because if you reload it when the user has changed some app
        // state, he/she could lose this state if it's not persisted
        // somewhere.

        LaunchManager.shared.launch(application, launchOptions: launchOptions)
        return true
    }

    static func reloadRootViewController() {

        DispatchQueue.main.async {

            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
    }
}
