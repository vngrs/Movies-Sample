//
//  PList.swift
//  Movies
//
//  Created by Abdelrahman Mohamed on 3.06.2020.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation

class PList {
    
    fileprivate let pListData: [String: Any]

    init(pListResource: String) throws {
        
        // Adapted from https://makeapppie.com/2016/02/11/how-to-use-property-lists-plist-in-swift/
        var format = PropertyListSerialization.PropertyListFormat.xml

        let pListPath: String? = Bundle.main.path(forResource: pListResource, ofType: "plist")

        let pListXML = FileManager.default.contents(atPath: pListPath!)!

        pListData = try (PropertyListSerialization.propertyList(from: pListXML, options: .mutableContainersAndLeaves, format: &format) as! [String: Any])
    }

    func getValue<T>(withKey key: String) -> T {
        return pListData[key] as! T
    }
}
