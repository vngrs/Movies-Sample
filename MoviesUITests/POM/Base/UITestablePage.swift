//
//  UITestablePage.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import Foundation

protocol UITestablePage {

    associatedtype UIElementType: UIElement

    func makeViewTestable(_ view: UIView, using element: UIElementType)
//    func makeViewTestable(_ view: UIView, using element: UIElementType, sequence: String)
}

extension UITestablePage {

    func makeViewTestable(_ view: UIView, using element: UIElementType) {
        view.accessibilityIdentifier = element.accessibilityIdentifier
    }

    func makeViewTestable(_ view: UIView, using element: UIElementType, sequence: String) {
//        view.accessibilityIdentifier = element.rawValue(withSequence: sequence)
    }
}
