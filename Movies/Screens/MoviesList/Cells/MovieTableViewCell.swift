//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct MovieCellPresentation: Presentation {

    let title: String
    let bannerUrl: URL?
}

class MovieTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!

    var presentation: MovieCellPresentation? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {

        titleLabel.text = presentation?.title
    }
}
