//
//  UserApiService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/27/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let apiService = ApiService()

struct UserDataService {
    func getMe() -> AnyPublisher<User, Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.userMe.rawValue, body: nil,
                                         httpMethod: HttpMethod.get.rawValue, headerFields: nil)
    }
    func getToken(body: Data) -> AnyPublisher<Token, Error> {
        return apiService.combineRequest(endpoint: RecipeEndpoint.token.rawValue, body: body,
                                         httpMethod: HttpMethod.post.rawValue,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue],
                                         useToken: false)
    }
}
