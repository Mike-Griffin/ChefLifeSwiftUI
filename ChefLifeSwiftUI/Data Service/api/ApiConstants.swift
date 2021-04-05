//
//  ApiConstants.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/24/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

enum RecipeEndpoint: String {
    // User Endpoints
    case userMe = "user/me/"
    case token = "user/token/"
    case signup = "user/create/"
    // Recipe Endpoints
    case measurements = "recipe/measurements/"
    case ingredients = "recipe/ingredients/"
    case tags = "recipe/tags/"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HeaderKeys: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

enum HeaderValues: String {
    case JSONUTF8 = "application/json; charset=utf-8"
}
