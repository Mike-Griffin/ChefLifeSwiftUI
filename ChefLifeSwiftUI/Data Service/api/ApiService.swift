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
let apiService = ApiService()

public struct ApiService {
    private static var cache: [String: Codable] = [:]
    func fetch<T: Codable>(endpoint: String, headerFields: [String: String]?,
                           useToken: Bool = true) -> AnyPublisher<T, Error> {
        if let cached = Self.cache[endpoint] as? T {
            return Just(cached)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        let urlString = baseEndpoint + endpoint
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
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
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map({ result in
                Self.cache[endpoint] = result
                return result
            })
            .eraseToAnyPublisher()
    }
    func post<T: Codable>(endpoint: String, body: Data,
                          headerFields: [String: String]?,
                          useToken: Bool = true) -> AnyPublisher<T, Error> {
        let urlString = baseEndpoint + endpoint
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.rawValue
        request.httpBody = body
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
                      httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map({ result in
                if var cached = Self.cache[endpoint] as? [T] {
                    cached.append(result)
                    Self.cache[endpoint] = cached
                } else {
                    Self.cache[endpoint] = result
                }
                return result
            })
            .eraseToAnyPublisher()
    }
}
