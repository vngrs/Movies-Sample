//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol ReviewOrderRouter: Router {

    static func routeToReviewOrder(from context: NavigationController, delegate: ReviewOrderViewControllerDelegate, title: String?)
}

extension ReviewOrderRouter {

    static func routeToReviewOrder(from context: NavigationController, delegate: ReviewOrderViewControllerDelegate, title: String? = nil) {

        let controller = ReviewOrderViewController.instantiate()
        controller.delegate = delegate
        controller.title = title
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

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelCheckoutTapped))
    }

    @objc func cancelCheckoutTapped() {

        delegate?.reviewOrderControllerDidCancel(self)
    }

    @IBAction func didExecuteAction() {

        delegate?.reviewOrderControllerDidFinish(self)
    }
}
