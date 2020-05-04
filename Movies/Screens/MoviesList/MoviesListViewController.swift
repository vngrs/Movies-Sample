//
//  ViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import CoreVNGRSKit

struct MoviesListPresentation: Presentation {

    var cellsPresentations: [MovieCellPresentation] = []

    mutating func update(with state: MoviesListState) {

        cellsPresentations = state.movies.map({
            return MovieCellPresentation(
                title: $0.title ?? "",
                releaseDate: $0.release_date,
                bannerUrl: URLBuilder.imageUrl(path: $0.poster_path ?? ""),
                rating: "\($0.vote_average ?? 0)",
                ratingColor: $0.voteColor
            )
        })
    }
}

class MoviesListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var playingButton: UIButton!
    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var filterButtons: [UIButton]!

    let viewModel = MoviesListViewModel()
    var presentation = MoviesListPresentation() {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        configureViews()
        addChangeHandlers()
        viewModel.loadMoreMovies()
    }

    private func configureViews() {

        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.cvkRegisterCell(type: MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self

        resetFiltersStyles()
        popularButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        filterButtons.forEach {
            $0.roundCorners(cornerRadius: 17.0)
        }
    }

    private func addChangeHandlers() {

        viewModel.addChangeHandler { [weak self] (change) in

            guard let self = self else { return }
            switch change {
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded:
                self.activityIndicator.stopAnimating()
                self.presentation.update(with: self.viewModel.state)
            case .failed(let error):
                self.activityIndicator.stopAnimating()
                self.showError(message: error)
            }
        }
    }

    private func updateUI() {

        tableView.reloadData()
        if viewModel.state.page == 1 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }

    @IBAction func didTapFilter(_ sender: UIButton) {

        switch sender {
        case popularButton:
            viewModel.switchToTab(.popular)
        case playingButton:
            viewModel.switchToTab(.playing)
        case nextButton:
            viewModel.switchToTab(.next)
        case topButton:
            viewModel.switchToTab(.top)
        default:
            break
        }
        resetFiltersStyles()
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }

    func resetFiltersStyles() {

        filterButtons.forEach {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}

extension MoviesListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return presentation.cellsPresentations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: MovieTableViewCell = tableView.cvkDequeueCell(for: indexPath)
        cell.presentation = presentation.cellsPresentations[indexPath.row]
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if offsetY > contentHeight - scrollView.frame.height * 4 {
            viewModel.loadMoreMovies()
        }
    }
}
