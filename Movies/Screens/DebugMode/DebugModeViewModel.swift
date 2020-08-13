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
