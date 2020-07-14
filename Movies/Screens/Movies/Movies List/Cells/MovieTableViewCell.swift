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

class MovieTableViewCell: TableViewCell, Accessible {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var rateView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!

    var presentation: MovieCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func applyStyling() {

        super.applyStyling()

        generateAccessibilityIdentifiers()

        bannerImageView.roundCorners(cornerRadius: 20.0)
        rateView.roundCorners(cornerRadius: 30.0)
        rateView.cvkApplyShadow()
        rateLabel.cvkApplyShadow()
    }

    func updateUI() {
        
        titleLabel.text = presentation?.title

//        titleLabel.font = UIFont(name: "Billion Dreams", size: 30)
        titleLabel.font = R.font.billionDreams(size: 30)

//        titleLabel.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        titleLabel.backgroundColor = R.color.lightGreen()

        releaseDate.text = presentation?.releaseDate
        releaseDate.backgroundColor = R.color.lightGreen()

        rateLabel.text = presentation?.rating
        rateLabel.textColor = presentation?.ratingColor

        bannerImageView.image = nil
        if let url = presentation?.bannerUrl {
            bannerImageView.af_setImage(withURL: url)
        }
    }
}
