//
//  CheckoutCoordinator.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol CheckoutCoordinatorDelegate: class {

    // TODO
}

class CheckoutCoordinator: Coordinator {

    enum OrderCheckoutStep {

        case address, payment, order
        var order: Int {
            switch self {
            case .address: return 0
            case .payment:  return 1
            case .order:    return 2
            }
        }
    }

    weak var outputDelegate: CoordinatorOutput?
    weak var delegate: CheckoutCoordinatorDelegate?
    var navigationController: NavigationController

    private var orderSteps: [OrderCheckoutStep] {

        return [.address, .payment, .order]
    }
    private var currentStep: Int = 0

    required init(_ navigationController: NavigationController) {

        self.navigationController = navigationController
        navigationController.customDelegate = self
    }

    func start() {

        showCurrentStep()
    }

    func showCurrentStep() {

        guard let orderStep = orderSteps.first(where: { $0.order == currentStep }) else { return }

        switch orderStep {
        case .address:
            AppRouter.routeToAddress(from: navigationController, delegate: self)
        case .payment:
            AppRouter.routeToPaymentMethod(from: navigationController, delegate: self)
        case .order:
            AppRouter.routeToReviewOrder(from: navigationController, delegate: self)
        }
    }
}

extension CheckoutCoordinator: AddressViewControllerDelegate {

    func addressControllerDidCancel(_ controller: AddressViewController) {

        finish()
    }

    func addressControllerDidFinish(_ controller: AddressViewController) {

        currentStep += 1
        showCurrentStep()
    }
}

extension CheckoutCoordinator: PaymentMethodViewControllerDelegate {

    func paymentMethodControllerDidCancel(_ controller: PaymentMethodViewController) {

        finish()
    }

    func paymentMethodControllerDidFinish(_ controller: PaymentMethodViewController) {

        currentStep += 1
        showCurrentStep()
    }
}

extension CheckoutCoordinator: ReviewOrderViewControllerDelegate {

    func reviewOrderControllerDidCancel(_ controller: ReviewOrderViewController) {

        finish()
    }

    func reviewOrderControllerDidFinish(_ controller: ReviewOrderViewController) {

        finish()
    }
}

extension CheckoutCoordinator: NavigationControllerDelegate {

    func navigationController(
    _ navigationController: NavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {

        currentStep = navigationController.viewControllers.count - 1
    }
}
