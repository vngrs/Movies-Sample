//
//  UIElement.swift
//  MoviesUITests
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

protocol UIElement {

    var accessibilityIdentifier: String { get }
}

extension UIElement where Self: RawRepresentable {

    var accessibilityIdentifier: RawValue {
        return self.rawValue
    }
}
