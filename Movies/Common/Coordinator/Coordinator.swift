//
//  Coordinator.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

// MARK: - Coordinator
public protocol Coordinator: class {

    var outputDelegate: CoordinatorOutput? { get set }
    var navigationController: NavigationController { get set }

    func start()
    func finish()

    init(_ navigationController: NavigationController)
}

// MARK: - CoordinatorOutput
public protocol CoordinatorOutput: class {

    func coordinatorDidFinish(coordinator: Coordinator)
}
