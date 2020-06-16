//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol PaymentMethodRouter: Router {

    static func routeToPaymentMethod(from context: BaseViewController)
}

extension PaymentMethodRouter {

    static func routeToPaymentMethod(from context: BaseViewController) {

        let controller = PaymentMethodViewController.instantiate()
        push(controller, from: context, animated: true)
    }
}

protocol PaymentMethodViewControllerDelegate: class {

    func paymentMethodControllerDidFinish(_ controller: PaymentMethodViewController)
}

class PaymentMethodViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: PaymentMethodViewControllerDelegate?

    @IBAction func didExecuteAction() {

        delegate?.paymentMethodControllerDidFinish(self)
    }
}
