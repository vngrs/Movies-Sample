//
//  ViewControllerAssembly.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 8.09.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

typealias SwinjectViewController = (StoryboardBased & Reusable)

class ViewControllerAssembly {
    
    class func makeMoviesListViewController() -> BaseViewController {
        let viewController = makeController(for: MoviesListViewController.self) as! MoviesListViewController
        viewController.viewModel = Assembler.instance.container.resolve(MoviesListViewModel.self)
        return viewController
    }
    
    class func makeMovieDetailsViewController(with movie: Movie) -> BaseViewController {
        let viewController = makeController(for: MovieDetailsViewController.self) as! MovieDetailsViewController
        viewController.viewModel = Assembler.instance.container.resolve(MovieDetailsViewModel.self, argument: movie)
        return viewController
    }
    
    class func makeCartViewController() -> BaseViewController {
        let viewController = makeController(for: CartViewController.self) as! CartViewController
        return viewController
    }
    
    private class func makeStoryboard(for storyboardName: String) -> SwinjectStoryboard {
        return SwinjectStoryboard.create(name: storyboardName, bundle: nil, container: Assembler.instance.container)
    }
    
    private class func makeController(for type: SwinjectViewController.Type) -> BaseViewController {
        return makeStoryboard(for: type.storyboardName).instantiateViewController(withIdentifier: type.reuseIdentifier) as! BaseViewController
    }
    
}
