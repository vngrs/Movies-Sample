//
//  BaseRequest.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

protocol BaseRequest: Request {

}

enum CustomHeaders {

    static var headers: [String: String] = [:]
}

extension BaseRequest {

    var defaultUrlParams: JSONDictionary {
        return [
              "api_key": "5513bda43722ed9c10f8d3e35f5a9c4e"
        ]
    }

    var headers: HTTPHeaderDictionary? {

        let version = Bundle.main.buildNumber

        var headers = [
            "Accept": "application/json",
            "X-OS-Name": "ios",
            "X-App-Version": version,
            "User-Agent": "iOSMobileApp",
            "Cache-Control": "no-cache"
        ]

        CustomHeaders.headers.forEach {

            headers[$0.key] = $0.value
        }

        return headers
    }

    var urlParameters: JSONDictionary? {
        return defaultUrlParams
    }
}
