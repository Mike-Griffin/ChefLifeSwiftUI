//
//  Recipe.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/6/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

struct Recipe: Identifiable, Codable, Equatable {
    let title: String
    let tags: [Int]
    let ingredientLines: [IngredientLineGet]
    let id: Int
}

struct IngredientLineGet: Codable, Equatable {
    // TODO need to determine how I link these things up...
    let ingredient: Int
    let order: Int
    let quantity: String
    let measurement: Int
}
