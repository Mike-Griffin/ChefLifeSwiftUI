//
//  IngredientLine.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/2/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

struct IngredientLine: Codable, Equatable {
    let measurement: QuantityMeasurement
    let quantity: Float
}
