//
//  NavigationController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit

public protocol NavigationControllerDelegate: class {

    func navigationController(
        _ navigationController: NavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    )

    func navigationController(
        _ navigationController: NavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    )
}

public extension NavigationControllerDelegate {

    func navigationController(
        _ navigationController: NavigationController,
        willShow viewController: UIViewController,
        animated: Bool) {}

    func navigationController(
        _ navigationController: NavigationController,
        didShow viewController: UIViewController,
        animated: Bool) {}
}

public class NavigationController: UINavigationController {

    public weak var customDelegate: NavigationControllerDelegate?

    internal var mainColor: UIColor = .gray

    open var shouldHideTabBarOnPush: Bool { true }

    override public func viewDidLoad() {

        super.viewDidLoad()

        delegate = self
    }

    public func setMainColor(_ color: UIColor) {
        mainColor = color
    }
}

extension NavigationController: UINavigationControllerDelegate {

    // swiftlint:disable all
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = viewController.transitionCoordinator, shouldHideTabBarOnPush == true {
            coordinator.notifyWhenInteractionChanges({ (context) in
                if context.isCancelled {
                    viewController.extendedLayoutIncludesOpaqueBars = true
                    navigationController.tabBarController?.tabBar.isHidden = true
                }
            })
        }

        if shouldHideTabBarOnPush {
            viewController.extendedLayoutIncludesOpaqueBars = navigationController.viewControllers.count > 1

            navigationController.tabBarController?.tabBar.isHidden = navigationController.viewControllers.count > 1
        }

        customDelegate?.navigationController(self, willShow: viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if shouldHideTabBarOnPush {
            viewController.extendedLayoutIncludesOpaqueBars = navigationController.viewControllers.count > 1

            navigationController.tabBarController?.tabBar.isHidden = navigationController.viewControllers.count > 1
        }

        customDelegate?.navigationController(self, didShow: viewController, animated: animated)
    }
}

public extension NavigationController {

    func pushFromBottomViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromTop
        view.layer.add(transition, forKey: kCATransition)
        pushViewController(viewController, animated: false)
    }

    func pushToBottomViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        transition.subtype = .fromBottom
        view.layer.add(transition, forKey: kCATransition)
        pushViewController(viewController, animated: false)
    }
}

extension UINavigationBar {

    class func applyDefaultStyling() {

        UINavigationBar.appearance().titleTextAttributes    = [.font: UIFont.systemFont(ofSize: 20, weight: .heavy),
                                                               .foregroundColor: UIColor.black]
        UINavigationBar.appearance().shadowImage            = UIImage()
        UINavigationBar.appearance().tintColor              = .white
        UINavigationBar.appearance().barTintColor           = .white
    }
}

extension UIBarButtonItem {

    class func applyDefaultStyling() {

        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
    }
}
