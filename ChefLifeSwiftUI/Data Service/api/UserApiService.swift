//
//  UserApiService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/27/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let apiService = RecipeApiService()

struct UserApiService {
    func getMe() -> AnyPublisher<User, Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.getMe.rawValue, body: nil,
                                         httpMethod: HttpMethod.get.rawValue, headerFields: nil)
    }
    func getToken(email: String, password: String) -> AnyPublisher<Token, Error> {
        let body: [String: Any] = ["email": "\(email)", "password": "\(password)"]
        let jsonDataBody = try! JSONSerialization.data(withJSONObject: body)
        return apiService.combineRequest(endpoint: RecipeEndpoint.token.rawValue, body: jsonDataBody,
                                         httpMethod: HttpMethod.post.rawValue,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue],
                                         useToken: false)
    }
}
