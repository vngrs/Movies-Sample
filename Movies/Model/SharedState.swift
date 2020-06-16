//
//  SharedState.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 6/16/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

class SharedState {

    static let instance = SharedState()

    private init() {}

    private(set) var userHasSavedAddress: Bool = false
    private(set) var userHasPaymentMethod: Bool = false

    func setUserHasAddress() {

        userHasSavedAddress = true
    }

    func setUserHasPaymentMethod() {

        userHasPaymentMethod = true
    }
}
