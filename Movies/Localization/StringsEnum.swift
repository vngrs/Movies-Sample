//
//  StringsEnum.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 3.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

enum StringsEnum {

    static let settings = "settings"
    static let movies = "movies"
    static let popular = "popular"
    static let playing = "playing"
    static let upcoming = "upcoming"
    static let top = "top"
    static let switchLanguage = "switchLanguage"
    static let cancel = "cancel"
    static let englishLanguage = "englishLanguage"
    static let arabicLanguage = "arabicLanguage"
    static let reopenStatus = "reopenStatus"
}

extension String {

    func localized() -> String {
        
        return NSLocalizedString(self, comment: "")
    }
}
