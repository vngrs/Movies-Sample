//
//  Language.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 4.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import UIKit

class Language {

    class func currentLanguage() -> String {

        let def = UserDefaults.standard

        let lang = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = lang.firstObject as! String

        return firstLang
    }

    class func setAppLanguage(lang: String) {

        let def = UserDefaults.standard

        def.set([lang, currentLanguage()], forKey: "AppleLanguages")
        def.synchronize()
    }

    class func localNotificationBody(language: String) -> String {

        if language == "en-US" {
            return "Language changed. Tap to open again."
        } else if language == "ar" {
            return "اللغة تغيرت اضغت لفتح التطبيق"
        }
        
        return "Language changed. Tap to open again."
    }

    class func createLocalNotification(language: String) {

        let notification = UILocalNotification()
        notification.fireDate = Date(timeIntervalSinceNow: 1)
        notification.alertBody = Language.localNotificationBody(language: language)
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)


        guard let settings = UIApplication.shared.currentUserNotificationSettings else { return }

        if settings.types == .none {

            return
        }
    }
}
