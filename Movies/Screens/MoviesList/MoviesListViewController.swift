//
//  ViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import CoreVNGRSKit

class MoviesListViewControllerViewController: UIViewController {

    let viewModel = MoviesListViewModel()

    override func viewDidLoad() {

        super.viewDidLoad()
        viewModel.loadMoviesList()
    }
}
