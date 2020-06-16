//
//  CheckoutCoordinatorRouter.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol CheckoutCoordinatorRouter: Router {

    static func routeToCheckout(from context: BaseViewController,
                         delegate: CheckoutCoordinatorDelegate?,
                         outputDelegate: CoordinatorOutput?
    )
}

extension CheckoutCoordinatorRouter {

    static func routeToCheckout(from context: BaseViewController,
                         delegate: CheckoutCoordinatorDelegate?,
                         outputDelegate: CoordinatorOutput?
    ) {

        let navigationVC = NavigationController()
        navigationVC.modalPresentationStyle = .overFullScreen
        navigationVC.navigationBar.tintColor = .black
        navigationVC.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                          .font: UIFont.systemFont(ofSize: 20, weight: .regular)]
        let coordinator = CheckoutCoordinator(navigationVC)
        coordinator.outputDelegate = outputDelegate
        coordinator.delegate = delegate
        coordinator.start()
        appDelegate?.activeCoordinators.append(coordinator)

        context.present(navigationVC, animated: true)
    }
}

extension AppRouter: CheckoutCoordinatorRouter {}
