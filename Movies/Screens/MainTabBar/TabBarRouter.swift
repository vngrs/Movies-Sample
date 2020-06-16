//
//  TabBarRouter.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarRouter: Router {

    static func routeToMainTabBar(animated: Bool)

    @discardableResult
    static func routeToTab(
        with class: BaseViewController.Type,
        from context: BaseViewController,
        popToRoot: Bool
        ) -> BaseViewController?
}

extension TabBarRouter {

    static func routeToMainTabBar(animated: Bool) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window else {

                return
        }

        let tabbarController = TabBarController()
        appDelegate.tabbarController = tabbarController

        if window.rootViewController != nil {

            UIView.transition(
                with: window,
                duration: animated ? 0.3 : 0,
                options: .transitionCrossDissolve,
                animations: {
                    let oldState: Bool = UIView.areAnimationsEnabled
                    UIView.setAnimationsEnabled(false)
                    window.rootViewController = tabbarController
                    UIView.setAnimationsEnabled(oldState)
            }, completion: nil)

        } else {
            window.rootViewController = tabbarController
            window.makeKeyAndVisible()
        }
    }

    @discardableResult
    static func routeToTab(
        with class: BaseViewController.Type,
        from context: BaseViewController,
        popToRoot: Bool
        ) -> BaseViewController? {

        return appDelegate?.tabbarController?.switchToTab(with: `class`, popToRoot: popToRoot)
    }
}

extension AppRouter: TabBarRouter {}
