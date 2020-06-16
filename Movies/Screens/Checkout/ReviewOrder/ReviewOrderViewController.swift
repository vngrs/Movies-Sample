//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol ReviewOrderRouter: Router {

    static func routeToReviewOrder(from context: BaseViewController)
}

extension ReviewOrderRouter {

    static func routeToReviewOrder(from context: BaseViewController) {

        let controller = ReviewOrderViewController.instantiate()
        push(controller, from: context, animated: true)
    }
}

protocol ReviewOrderViewControllerDelegate: class {

    func reviewOrderControllerDidFinish(_ controller: ReviewOrderViewController)
}

class ReviewOrderViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: ReviewOrderViewControllerDelegate?

    @IBAction func didExecuteAction() {

        delegate?.reviewOrderControllerDidFinish(self)
    }
}
