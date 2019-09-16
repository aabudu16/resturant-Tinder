//
//  Network.swift
//  Resturant-Tinder
//
//  Created by Mr Wonderful on 9/16/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkHelper {
    // MARK: - Static Properties
    static let shared = NetworkHelper()
    // MARK: - Internal Properties
    func performDataTask(withUrl urlStr: String,
                         andHTTPBody body: Data? = nil,
                         andMethod httpMethod: HTTPMethod,
                         completionHandler: @escaping ((Result<Data, AppError>) -> Void)) {
        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(TeamAPIKeys.tiaAPIKey)", forHTTPHeaderField: "Authorization")
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    completionHandler(.failure(.badStatusCode))
                    return
                }
                if let error = error {
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                        completionHandler(.failure(.noInternetConnection))
                        return
                    } else {
                        completionHandler(.failure(.other(rawError: error)))
                        return
                    }
                }
                completionHandler(.success(data))
            }
            }.resume()
    }
    // MARK: - Private Properties and Initializers
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    private init() {}
}

