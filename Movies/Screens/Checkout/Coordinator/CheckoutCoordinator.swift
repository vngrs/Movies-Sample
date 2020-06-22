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
    }

    weak var outputDelegate: CoordinatorOutput?
    weak var delegate: CheckoutCoordinatorDelegate?
    var navigationController: NavigationController

    private var orderSteps: [OrderCheckoutStep] = []
    private var currentStep: Int = 0

    required init(_ navigationController: NavigationController) {

        self.navigationController = navigationController
        navigationController.customDelegate = self

        if !SharedState.instance.userHasSavedAddress {

            orderSteps.append(.address)
        }
        if !SharedState.instance.userHasPaymentMethod {

            orderSteps.append(.payment)
        }
        orderSteps.append(.order)
    }

    func start() {

        showCurrentStep()
    }

    func showCurrentStep() {

        guard let stepInfo = orderSteps.enumerated().first(where: { $0.offset == currentStep }) else { return }

        let stepTitle = "\(stepInfo.offset+1) / \(orderSteps.count)"
        switch stepInfo.element {
        case .address:
            AppRouter.routeToAddress(from: navigationController, delegate: self, title: stepTitle)
        case .payment:
            AppRouter.routeToPaymentMethod(from: navigationController, delegate: self, title: stepTitle)
        case .order:
            AppRouter.routeToReviewOrder(from: navigationController, delegate: self, title: stepTitle)
        }
    }
}

extension CheckoutCoordinator: AddressViewControllerDelegate {

    func addressControllerDidCancel(_ controller: AddressViewController) {

        finish()
    }

    func addressControllerDidFinish(_ controller: AddressViewController) {

        SharedState.instance.setUserHasAddress()
        currentStep += 1
        showCurrentStep()
    }
}

extension CheckoutCoordinator: PaymentMethodViewControllerDelegate {

    func paymentMethodControllerDidCancel(_ controller: PaymentMethodViewController) {

        finish()
    }

    func paymentMethodControllerDidFinish(_ controller: PaymentMethodViewController) {

        SharedState.instance.setUserHasPaymentMethod()
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
