//
//  UserApiService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/27/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

let userService = UserDataService()

struct UserDataService {
    func getMe() -> AnyPublisher<User, Error> {
        return apiService.fetch(endpoint: RecipeEndpoint.userMe.rawValue,
                                headerFields: nil)
    }
    func getToken(body: Data) -> AnyPublisher<Token, Error> {
        return apiService.post(endpoint: RecipeEndpoint.token.rawValue, body: body,
                                         headerFields: [HeaderKeys.contentType.rawValue:
                                                            HeaderValues.JSONUTF8.rawValue],
                                         useToken: false)
    }
    func signUp(body: Data) -> AnyPublisher<User, Error> {
        return apiService.post(endpoint: RecipeEndpoint.signup.rawValue, body: body,
                              headerFields: [HeaderKeys.contentType.rawValue:
                                                HeaderValues.JSONUTF8.rawValue],
                              useToken: false)
    }
}
