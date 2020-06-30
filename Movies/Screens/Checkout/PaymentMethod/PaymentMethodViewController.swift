//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol PaymentMethodRouter: Router {

    static func routeToPaymentMethod(from context: NavigationController, delegate: PaymentMethodViewControllerDelegate, title: String?)
}

extension PaymentMethodRouter {

    static func routeToPaymentMethod(from context: NavigationController, delegate: PaymentMethodViewControllerDelegate, title: String? = nil) {

        let controller = PaymentMethodViewController.instantiate()
        controller.delegate = delegate
        controller.title = title
        context.pushViewController(controller, animated: true)
    }
}

extension AppRouter: PaymentMethodRouter {}

protocol PaymentMethodViewControllerDelegate: class {

    func paymentMethodControllerDidFinish(_ controller: PaymentMethodViewController)
    func paymentMethodControllerDidCancel(_ controller: PaymentMethodViewController)
}

class PaymentMethodViewController: ViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: PaymentMethodViewControllerDelegate?

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelCheckoutTapped))
    }

    @objc func cancelCheckoutTapped() {

        delegate?.paymentMethodControllerDidCancel(self)
    }

    @IBAction func didExecuteAction() {

        delegate?.paymentMethodControllerDidFinish(self)
    }
}
