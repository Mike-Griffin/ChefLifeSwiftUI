//
//  CreateIngredientLineViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/31/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

class CreateIngredientLineViewModel: ObservableObject {
    @Published var quantity: String = ""
    @Published var selectedMeasurement: QuantityMeasurement?
    @Published var selectedIngredient: Ingredient?

    func addIngredient(_ count: Int) -> IngredientLine? {
        guard !quantity.isEmpty, let quantityFloat = Float(quantity), let measurement = selectedMeasurement,
              let ingredient = selectedIngredient else {
            // TODO return error indicating that all these need values
            return nil
        }
        return IngredientLine(measurement: measurement, ingredient: ingredient,
                                              quantity: quantityFloat, id: count + 1)
    }
}
