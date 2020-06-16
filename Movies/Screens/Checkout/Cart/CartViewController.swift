//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol CartRouter: Router {

    static func routeToCart(from context: BaseViewController)
}

extension CartRouter {

    static func routeToCart(from context: BaseViewController) {

        let controller = CartViewController.instantiate()
        push(controller, from: context, animated: true)
    }
}

protocol CartViewControllerDelegate: class {

    func cartControllerDidFinish(_ controller: CartViewController)
}

class CartViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: CartViewControllerDelegate?

    @IBAction func didExecuteAction() {

        AppRouter.routeToCheckout(from: self, delegate: nil, outputDelegate: nil)
    }
}
