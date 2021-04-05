//
//  IngredientLine.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/2/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

struct IngredientLine: Codable, Equatable, Identifiable {
    var measurement: QuantityMeasurement?
    var ingredient: Ingredient?
    var quantity: Float?
    let id: Int
}
