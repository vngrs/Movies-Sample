//
//  WelcomeViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

class WelcomeViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Main"

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)
        AppRouter.routeToMainTabBar(animated: true)
    }
}
