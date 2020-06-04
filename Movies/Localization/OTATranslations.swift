//
//  OTATranslations.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 3.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import PhraseSDK

class OTATranslations {

    static let shared = OTATranslations()

    private init() {
        #if DEBUG
        Phrase.shared.debugMode = true
        #endif

        let config: PList? = loadConfig()

        if let config = config {
            #if DEBUG
            let environmentTokenKey: String = "devToken"
            #else
            let environmentTokenKey: String = "prodToken"
            #endif

            Phrase.shared.setup(
                distributionID: config.getValue(withKey: "distributionID"),
                environmentSecret: config.getValue(withKey: environmentTokenKey),
                timeout: config.getValue(withKey: "timeout")
                )
        }
    }

    func updateTranslations(onUpdateComplete: (() -> Void)? = nil) {
        do {
            try Phrase.shared.updateTranslations(completionHandler: { (resut) in

                switch resut {


                case .success(let updated):
                    if updated {
                        print("Translations updated successfully")

                        onUpdateComplete?()
                    } else {
                        print("No new translations found")
                    }
                case .failure(_):
                    print("Failure updating translations")
                }
            })
        } catch {
            print("Error updating translations: \(error)")
        }
    }

    fileprivate func loadConfig() -> PList? {
        do {
            return try PList(pListResource: "PhraseApp")
        } catch {
            print("Error loading PhraseApp configuration from plist, \(error)")
        }

        return nil
    }
}
