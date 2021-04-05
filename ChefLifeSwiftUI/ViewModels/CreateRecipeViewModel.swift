//
//  CreateRecipeViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/2/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation

class CreateRecipeViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var ingredientLines: [IngredientLine] = []
    @Published var tags: [Tag] = []
}
