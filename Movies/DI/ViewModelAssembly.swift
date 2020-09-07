//
//  ViewModelAssembly.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 8.09.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(MoviesListViewModel.self) { resolver in
            return MoviesListViewModel(dataSource: resolver.resolve(MovieModel.self)!)
        }
        
        container.register(MovieDetailsViewModel.self) { resolver, movie in
            return MovieDetailsViewModel(movie: movie)
        }
    }
    
}
