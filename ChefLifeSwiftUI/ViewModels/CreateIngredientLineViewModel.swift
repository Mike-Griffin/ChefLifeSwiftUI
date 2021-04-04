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
}
