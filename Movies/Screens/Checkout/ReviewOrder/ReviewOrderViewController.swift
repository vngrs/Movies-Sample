//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol ReviewOrderRouter: Router {

    static func routeToReviewOrder(from context: NavigationController, delegate: ReviewOrderViewControllerDelegate)
}

extension ReviewOrderRouter {

    static func routeToReviewOrder(from context: NavigationController, delegate: ReviewOrderViewControllerDelegate) {

        let controller = ReviewOrderViewController.instantiate()
        controller.delegate = delegate
        context.pushViewController(controller, animated: true)
    }
}

extension AppRouter: ReviewOrderRouter {}

protocol ReviewOrderViewControllerDelegate: class {

    func reviewOrderControllerDidFinish(_ controller: ReviewOrderViewController)
    func reviewOrderControllerDidCancel(_ controller: ReviewOrderViewController)
}

class ReviewOrderViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: ReviewOrderViewControllerDelegate?

    @IBAction func didExecuteAction() {

        delegate?.reviewOrderControllerDidFinish(self)
    }
}
