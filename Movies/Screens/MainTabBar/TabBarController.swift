//
//  TabBarController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import Foundation

struct TabInfo {

    var title: String
    var icon: UIImage
    var viewController: BaseViewController.Type
}

extension TabInfo: Equatable {

    static func == (lhs: TabInfo, rhs: TabInfo) -> Bool {

        return (
            lhs.title == rhs.title &&
                lhs.viewController == rhs.viewController
        )
    }
}

class TabBarController: UITabBarController {

    private enum Constants {

        static let titleOffset = UIOffset(horizontal: 0.0, vertical: -4.0)
    }

    private(set) var tabInfoItems: [TabInfo] = [

        TabInfo(
            title: "Movies",
            icon: Asset.movie.image,
            viewController: MoviesListViewController.self
        ),
        TabInfo(
            title: "Checkout",
            icon: Asset.cart.image,
            viewController: CartViewController.self
        )
    ]

    // MARK: - Designated initializer

    init() {

        super.init(nibName: nil, bundle: nil)

        setupViewControllers()
    }

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        setupViewControllers()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {

        super.viewDidLoad()
        applyStyling()
    }

    private func setupViewControllers() {

        var tabViewControllers: [BaseViewController] = []
        var insertionIndex = 0

        for tab in tabInfoItems {

            if let type = tab.viewController.self as? StoryboardBased.Type {
                if let vc = type.instantiate() as? BaseViewController {

                    switch vc {

                    case let moviesController as MoviesListViewController:
                        print("Adding movies list")
                    case let cart as CartViewController:
                        print("Adding cart")
                    default:
                        break
                    }

                    let tabBarItem = UITabBarItem(
                        title: tab.title,
                        image: tab.icon,
                        tag: tabInfoItems.firstIndex(of: tab) ?? -1
                    )
                    tabBarItem.titlePositionAdjustment = Constants.titleOffset
                    vc.tabBarItem = tabBarItem

                    tabViewControllers.append(vc)
                }
            }
        }

        viewControllers = tabViewControllers.map { UINavigationController(rootViewController: $0) }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if item.tag != 1 {

            if let navController = self.viewControllers?[1] as? UINavigationController {

                // TODO add controller specific logic if needed
            }
        }
    }

    // MARK: - Styling

    private func applyStyling() {

        tabBar.barTintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .black
        tabBar.layer.borderWidth = 0
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.clipsToBounds = true
        UITabBarItem.appearance().badgeColor = .black
    }

    // MARK: - Routing

    @discardableResult
    func switchToTab(at index: Int, popToRoot: Bool = false) -> BaseViewController? {

        guard index >= 0 && index < viewControllers?.count ?? 0 else {
            return nil
        }

        selectedIndex = index

        guard let controllers = viewControllers as? [UINavigationController] else {
            return nil
        }
        if popToRoot && index >= 0 && index < controllers.count {
            controllers[index].popToRootViewController(animated: false)
        }

        let rootController = controllers[index].viewControllers.first as? BaseViewController
        return rootController
    }

    @discardableResult
    func switchToTab(with class: BaseViewController.Type, popToRoot: Bool = false) -> BaseViewController? {

        guard let index = tabInfoItems.firstIndex(where: { $0.viewController == `class` }) else {
            return nil
        }
        return switchToTab(at: index, popToRoot: popToRoot)
    }
}

// MARK: - Tab bar visibility toggle helpers

extension UITabBarController {

    private func isTabBarVisible() -> Bool {

        return tabBar.frame.origin.y < view.frame.maxY
    }

    func setTabBarVisible(_ visible: Bool) {

        guard isTabBarVisible() != visible else {
            return
        }

        let height = tabBar.frame.size.height
        let offsetY = (visible ? -height : height)

        if visible {
            tabBar.isHidden = false
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.tabBar.frame = self.tabBar.frame.offsetBy(dx: 0, dy: offsetY)
            self.tabBar.isHidden = !visible
        })
    }
}
