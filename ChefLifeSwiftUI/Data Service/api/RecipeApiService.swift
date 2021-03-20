//
//  RecipeApiService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/19/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import KeychainSwift

let apiEndpoint = "http://127.0.0.1:8000/api/"

struct KeychainKeys {
    static let keyPrefix = "comedichoney_"
    static let token = "token"
}

public struct RecipeApiService {
    func apiRequest<T: Codable>(request: String, body: Data?, httpMethod: String, headerFields: [String: String], useToken: Bool = true, completion: @escaping (Result<T, Error>) -> ()) {

        if useToken {
//        guard let token = keychain.get(KeychainKeys.token) else {
//            return
//        }
        }
        
        let urlString = apiEndpoint + request
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            if useToken {
                //            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
            }
            request.httpMethod = httpMethod
            for header in headerFields {
                print(header.key)
                print(header.value)
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = body
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    var results : T
                    if let jsonParsed = try? decoder.decode(T.self, from: data) {
                        results = jsonParsed
                        completion(.success(results))
                    } else {
                        print("error with decoding")
                        // TODO create an error for the completion handler?
                    }
                }
            }
            task.resume()
        }
    }
}
