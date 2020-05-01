//
//  ViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import CoreVNGRSKit

class MoviesListViewControllerViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let viewModel = MoviesListViewModel()

    override func viewDidLoad() {

        super.viewDidLoad()
        addChangeHandlers()
    }

    private func addChangeHandlers() {

        viewModel.addChangeHandler { [weak self] (change) in

            guard let self = self else { return }
            switch change {
            case .loading:
                break
            case .loaded:
                break
            case .failed(let error):
                self.showError(message: error)
            }
        }
    }
}
