//
//  Assembler.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 8.09.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import Swinject

class Assembler {
    
    static let instance = Assembler()
    
    let container = Container()
    private let assembler: Swinject.Assembler
    
    private init() {
        assembler = .init([
            ViewModelAssembly(),
            RESTAssembly()
        ], container: container)
    }
}
