//
//  UIElements.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

enum UIElements: String, UIElement {

    // Home Screen Elements
    case homeRoot
    case homeTableView
    case homePopularButton
    case homePlayButton
    case homeUpcomingButton
    case homeTopButton

    // MARK: -  Cells

    // Movie Cell
    case movieCell
    case movieCellTitle
    case movieCellPoints
    case movieCellDate
}
