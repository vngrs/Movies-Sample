//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit
import AlamofireImage

struct MovieCellPresentation: Presentation {

    let title: String
    let releaseDate: String?
    let bannerUrl: URL?
    let rating: String?
    let ratingColor: UIColor?
}

class MovieTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var rateLabel: UILabel!

    var presentation: MovieCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func applyStyling() {

        super.applyStyling()
        bannerImageView.roundCorners(cornerRadius: 20.0)
        rateView.roundCorners(cornerRadius: 30.0)
        rateView.cvkApplyShadow()
        rateLabel.cvkApplyShadow()
    }

    func updateUI() {

        titleLabel.text = presentation?.title
        releaseDate.text = presentation?.releaseDate
        rateLabel.text = presentation?.rating
        rateLabel.textColor = presentation?.ratingColor
        bannerImageView.image = nil
        if let url = presentation?.bannerUrl {
            bannerImageView.af_setImage(withURL: url)
        }
    }
}
