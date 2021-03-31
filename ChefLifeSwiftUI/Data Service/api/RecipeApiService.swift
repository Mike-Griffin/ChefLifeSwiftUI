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
    func combineRequest<T: Codable>(endpoint: String, body: Data?, httpMethod: String,
                                    headerFields: [String: String]?,
                                    useToken: Bool = true) -> AnyPublisher<T, Error> {
        let urlString = baseEndpoint + endpoint
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        if let body = body {
            request.httpBody = body
        }
        if useToken {
            let keychainService = KeychainService()
            let token = keychainService.getToken()!
            request.setValue("Token \(token)", forHTTPHeaderField: HeaderKeys.authorization.rawValue)
        }
        if let headerFields = headerFields {
            for header in headerFields {
                request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 || httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map({ result in
                return result
            })
            .eraseToAnyPublisher()
    }
}
