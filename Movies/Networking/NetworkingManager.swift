//
//  NetworkingManager.swift
//  Movies
//
//  Created by Ahmed Abdurrahman on 4/30/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import Foundation
import CoreVNGRSKit

class NetworkingManager: CoreVNGRSKit.NetworkManager {

    enum Authorization {

        static let username = ""
        static let password = ""
    }

    static let shared: NetworkingManager = NetworkingManager()

    init() {

        super.init(host: "NO-HOST, use setHost before starting requests")
    }

    func setHost(_ host: String) {

        self.host = host
    }

    @discardableResult
    func start<T: Decodable>(
        dataModelRequest: BaseRequest,
        options: JSONSerialization.ReadingOptions = [],
        completion: ((Response<T>) -> Void)?
        ) -> URLSessionTask? {

        let serializer = JSONResponseSerializer(options: options)
        return start(request: dataModelRequest, serializer: serializer) { response in
            let result: CoreVNGRSKit.Result<T>
            switch response.result {
            case .success:
                if let error = self.validateResponse(response, serializer: serializer) {
                    result = .failure(error)
                } else if let data = response.data {
                    do {
                        result = .success(try JSONDecoder().decode(T.self, from: data))
                    } catch {
                        print("JSON Mapping Error : \(error.localizedDescription)")
                        result = .failure(.invalidJSONMapping)
                    }
                } else {
                    result = .failure(.invalidJSONMapping)
                }
            case .failure(let error):
                if let data = response.data {
                    print(
                        "Response data for error is : \(String(data: data, encoding: .utf8) ?? "")"
                    )
                }
                print(error.localizedDescription)
                result = .failure(error)
            }

            completion?(response.updating(result: result))
        }
    }

    func validateResponse<T: ResponseSerializer>(_ response: Response<T.Object>, serializer: T  ) -> NetworkError? {

        guard !(200 ... 299 ~= response.response?.statusCode ?? 0),
            let data = response.data else {
            return nil
        }

        return .invalidJSONMapping
    }
}
