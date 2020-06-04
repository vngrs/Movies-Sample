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

        let notification = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
//        content.title = "Reminder"
        content.body = localNotificationBody(language: language)
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)

        notification.add(request) { (error) in

            if error != nil {

                print("Error \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
}
