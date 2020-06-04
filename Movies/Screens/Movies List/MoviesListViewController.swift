//
//  ViewController.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 3/25/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit
import CoreVNGRSKit

class MoviesListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var popularButton: UIButton!
    @IBOutlet weak var playingButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
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

        title = StringsEnum.movies.localized()
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.cvkRegisterCell(type: MovieTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self

        resetFiltersStyles()
        popularButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        filterButtons.forEach {
            $0.roundCorners(cornerRadius: 17.0)
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: StringsEnum.settings.localized(), style: .done, target: self, action: #selector(didTapChangeLanguage(_:)))

        popularButton.setTitle(StringsEnum.popular.localized(), for: .normal)
        playingButton.setTitle(StringsEnum.playing.localized(), for: .normal)
        nextButton.setTitle(StringsEnum.upcoming.localized(), for: .normal)
        topButton.setTitle(StringsEnum.top.localized(), for: .normal)
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

    @objc func didTapChangeLanguage(_ sender: Any) {

        changeLanguage()
    }

    // MARK: - changeLanguage

    func changeLanguage() {

        let optionMenu = UIAlertController(title: "", message: StringsEnum.switchLanguage.localized(), preferredStyle: .actionSheet)

        // Add actions to the menu
        let cancelAction = UIAlertAction(title: StringsEnum.cancel.localized(), style: .cancel, handler: nil)

        let englishAction = UIAlertAction(title: StringsEnum.englishLanguage.localized(), style: .default, handler: { (action) in

            Language.setAppLanguage(lang: "en-US")
            self.makeAlert(lang: "en-US")
        })

        let arabicAction = UIAlertAction(title: StringsEnum.arabicLanguage.localized(), style: .default) { (action) in

            Language.setAppLanguage(lang: "ar")
            self.makeAlert(lang: "ar")
        }

        optionMenu.addAction(englishAction)
        optionMenu.addAction(arabicAction)
        optionMenu.addAction(cancelAction)

        // Display the menu
        self.present(optionMenu, animated: true, completion: nil)
    }

    // MARK: - makeAlert

    func makeAlert(lang: String) {

        let alertMenu = UIAlertController(title: StringsEnum.switchLanguage.localized(), message: StringsEnum.reopenStatus.localized(), preferredStyle: .alert)

        // Add actions to the menu
        let cancelAction = UIAlertAction(title: StringsEnum.cancel.localized(), style: .cancel, handler: { (action) in

            return
        })

        let okAction = UIAlertAction(title: StringsEnum.switchLanguage.localized(), style: .default, handler: { (action) in

            Language.createLocalNotification(language: lang)
            exit(0)
        })

        alertMenu.addAction(cancelAction)
        alertMenu.addAction(okAction)

        // Display the menu
        self.present(alertMenu, animated: true, completion: nil)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        DispatchQueue.main.async {
            if let movie = self.viewModel.state.movies[safe: indexPath.row] {
                AppRouter.routeToMovieDetail(from: self, movie: movie)
            }
        }
    }
}
