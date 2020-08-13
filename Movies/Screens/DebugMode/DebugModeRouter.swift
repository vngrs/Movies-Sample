//
//  DebugModeRouter.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 6.08.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

protocol DebugModeRouter: Router {

    static func routeToDebugMode(from context: BaseViewController)
}

extension DebugModeRouter {

    static func routeToDebugMode(from context: BaseViewController) {

        let controller = DebugModeViewController.instantiate()
        controller.viewModel = DebugModeViewModel()
        present(controller, from: context, animated: true)
    }
}

extension AppRouter: DebugModeRouter {}
