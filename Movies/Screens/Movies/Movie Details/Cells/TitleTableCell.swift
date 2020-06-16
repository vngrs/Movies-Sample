//
//  TitleTableCell.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 5/31/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

struct TitleCellPresentation: Presentation {

    var title: String?
}

class TitleTableCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    var presentation: TitleCellPresentation? {
        didSet {
            updateUI()
        }
    }

    override func applyStyling() {

        super.applyStyling()
        titleLabel.font = .systemFont(ofSize: 38, weight: .bold)
    }

    func updateUI() {

        titleLabel.text = presentation?.title
    }
}
