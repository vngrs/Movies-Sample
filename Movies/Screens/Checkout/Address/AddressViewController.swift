//
//  CartViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol AddressRouter: Router {

    static func routeToAddress(from context: NavigationController, delegate: AddressViewControllerDelegate)
}

extension AddressRouter {

    static func routeToAddress(from context: NavigationController, delegate: AddressViewControllerDelegate) {

        let controller = AddressViewController.instantiate()
        controller.delegate = delegate
        context.pushViewController(controller, animated: true)
    }
}

extension AppRouter: AddressRouter {}

protocol AddressViewControllerDelegate: class {

    func addressControllerDidFinish(_ controller: AddressViewController)
    func addressControllerDidCancel(_ controller: AddressViewController)
}

class AddressViewController: BaseViewController, StoryboardBased {

    static var storyboardName: String = "Checkout"

    weak var delegate: AddressViewControllerDelegate?

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelCheckoutTapped))
    }

    @objc func cancelCheckoutTapped() {

        delegate?.addressControllerDidCancel(self)
    }

    @IBAction func didExecuteAction() {

        delegate?.addressControllerDidFinish(self)
    }
}
