//
//  CreateRecipeViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/2/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let recipeService = RecipeDataService()

class CreateRecipeViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var ingredientLines: [IngredientLine] = []
    @Published var tags: [Tag] = []
    @Published var createdRecipe: Recipe?
    private var cancellables = Set<AnyCancellable>()
    func createRecipe() {
        guard !title.isEmpty, !ingredientLines.isEmpty, !tags.isEmpty else {
            // TODO add an error
            return
        }
        let mappedTags = tags.map( { $0.id })
        print(mappedTags)
        let mappedIngredients = ingredientLines.map( { ["order": $0.id, "quantity": $0.quantity!, "ingredient": $0.ingredient!.id, "measurement": $0.measurement!.id] })
        print(mappedIngredients)
         let body: [String: Any] = ["title": "\(title)", "tags": mappedTags, "ingredientLines": mappedIngredients]
        guard let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) else {
            // TODO make this an error
            return
        }
        recipeService.createRecipe(body: jsonDataBody)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("create recipe publisher is finished")
                }
            }, receiveValue: { (result) in
                self.createdRecipe = result
            }).store(in: &cancellables)
    }
}
