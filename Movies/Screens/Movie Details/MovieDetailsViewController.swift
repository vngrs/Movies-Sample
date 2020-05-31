//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

class MovieDetailsViewController: StaticTableViewController, StoryboardBased {

    static var storyboardName: String = "Main"

    @IBOutlet weak var tableView: UITableView!
    let titleCell = TitleTableCell.instanceFromNib()

    var viewModel: MovieDetailsViewModel!

    override func viewDidLoad() {

        super.viewDidLoad()
        configureViews()
        addChangeHandlers()
    }

    func configureViews() {

      configureFieldsTableView()
      configureCells()
    }

    func addChangeHandlers() {

        viewModel.addChangeHandler { [weak self] (change) in
        guard let self = self else {return}

            switch change {
                // TODO
            }
        }
    }

    private func configureFieldsTableView() {

        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200.0, right: 0)
        tableViewAccessor = tableView
        tableView.sectionFooterHeight = 0.0
    }

    private func configureCells() {

        var cells: [TableViewCell] = []

        titleCell.presentation = TitleCellPresentation(title: viewModel.state.movie.title)
        cells.append(titleCell)

        self.sections = [cells]
    }
}
