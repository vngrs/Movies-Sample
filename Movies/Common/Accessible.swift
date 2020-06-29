//
//  Accessible.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 25.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

protocol Accessible {
    
    func generateAccessibilityIdentifiers()
}

extension Accessible {

    func generateAccessibilityIdentifiers() {

//        #if DEBUG
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if
                let view = child.value as? UIView,
                let identifier = child.label?.replacingOccurrences(of: ".storage", with: "") {

                view.accessibilityIdentifier = "\(type(of: self)).\(identifier)"
                print(view.accessibilityIdentifier ?? "")
            }
        }
//        #endif
    }
}
