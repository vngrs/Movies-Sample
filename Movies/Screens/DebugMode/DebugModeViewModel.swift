//
//  DebugModeViewModel.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 6.08.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct DebugModeState {

    enum Change: StateChange {
        case mode
    }
}

class DebugModeViewModel: StatefulViewModel<DebugModeState.Change> {

    var state: DebugModeState
    let defaults = UserDefaults.standard

    override init() {
        state = DebugModeState()
    }

    func setMode(mode: String) {

        defaults.set(mode, forKey: "mode")
        print("Mode", mode)
        emit(change: .mode)
    }
}

//public extension UIColor {
//
//    /// Creates a color object that generates its color data dynamically using the specified colors. For early SDKs creates light color.
//    /// - Parameters:
//    ///   - light: The color for light mode.
//    ///   - dark: The color for dark mode.
//    convenience init(light: UIColor, dark: UIColor) {
//        if #available(iOS 13.0, tvOS 13.0, *) {
//            self.init { traitCollection in
//                if traitCollection.userInterfaceStyle == .dark {
//                    return dark
//                }
//                return light
//            }
//        }
//        else {
//            self.init(cgColor: light.cgColor)
//        }
//    }
//}
