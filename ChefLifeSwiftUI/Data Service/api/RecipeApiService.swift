//
//  RecipeApiService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/19/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

let baseEndpoint = "http://127.0.0.1:8000/api/"



public struct RecipeApiService {
    
    // TODO make all these values (enpoint, httpMethod, headerFields) an enum instead of a string
    func combineRequest<T: Codable>(endpoint: String, body: Data?, httpMethod: String, headerFields: [String: String]?, useToken: Bool = true) -> AnyPublisher<T, Error> {
        
        let urlString = baseEndpoint + endpoint
        
        print(urlString)
        print(httpMethod)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        if let body = body {
            request.httpBody = body
        }
        if useToken {
            let keychainService = KeychainService()
            let token = keychainService.getToken()!
            print(token)
            request.setValue("Token \(token)", forHTTPHeaderField: HeaderKeys.Authorization.rawValue)
            print(request)
        }
        if let headerFields = headerFields {
            for header in headerFields {
                print(header.key)
                print(header.value)
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map({ result in
                print("successful api call")
                // Not sure that I need this map...unsure exactly what it's doing
                return result
            })
            .eraseToAnyPublisher()
    }
    
//    func apiRequest<T: Codable>(request: String, body: Data?, httpMethod: String, headerFields: [String: String]?, useToken: Bool = true, completion: @escaping (Result<T, Error>) -> ()) {
//
//        if useToken {
////        guard let token = keychain.get(KeychainKeys.token) else {
////            return
////        }
//        }
//
//        let urlString = baseEndpoint + request
//        if let url = URL(string: urlString) {
//            var request = URLRequest(url: url)
//            if useToken {
//                //            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
//            }
//            request.httpMethod = httpMethod
//            if let headerFields = headerFields {
//                for header in headerFields {
//                    print(header.key)
//                    print(header.value)
//                    request.setValue(header.value, forHTTPHeaderField: header.key)
//                }
//            }
//            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//            request.httpBody = body
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    completion(.failure(error))
//                }
//                if let response = response as? HTTPURLResponse {
//                    print("Response HTTP Status code: \(response.statusCode)")
//                }
//                if let data = data {
//                    let decoder = JSONDecoder()
//                    var results : T
//                    if let jsonParsed = try? decoder.decode(T.self, from: data) {
//                        results = jsonParsed
//                        completion(.success(results))
//                    } else {
//                        print("error with decoding")
//                        // TODO create an error for the completion handler?
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
}
