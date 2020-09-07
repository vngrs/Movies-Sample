//
//  RESTAssembly.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 8.09.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import Swinject

class RESTAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MovieModel.self) { _ in
            return RESTMovieModel()
        }
    }
    
}
