//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol AddressRouter: Router {

    static func routeToAddress(from context: BaseViewController)
}

extension AddressRouter {

    static func routeToAddress(from context: BaseViewController) {

        let controller = AddressViewController.instantiate()
        push(controller, from: context, animated: true)
    }
}

protocol AddressViewControllerDelegate: class {

    func addressControllerDidFinish(_ controller: AddressViewController)
}

class AddressViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: AddressViewControllerDelegate?

    @IBAction func didExecuteAction() {

        delegate?.addressControllerDidFinish(self)
    }
}
