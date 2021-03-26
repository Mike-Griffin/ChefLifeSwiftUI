//
//  ApiConstants.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/24/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

enum RecipeEndpoint : String {
    case me = "user/me/"
    case token = "user/token/"
    case signup = "user/create/"
}

enum HttpMethod : String {
    case get = "GET"
    case post = "POST"
}

enum HeaderKeys : String {
    case Authorization = "Authorization"
    case ContentType = "Content-Type"
}

enum HeaderValues : String {
    case JSONUTF8 = "application/json; charset=utf-8"
}
