//
//  SelectIngredientViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

private let recipeService = RecipeDataService()

class SelectIngredientViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var ingredients: [Ingredient] = [] {
        didSet {
            for ingredient in ingredients {
                selectables.append(SelectableHolder(selectable: ingredient))
            }
        }
    }
    @Published var selectables: [SelectableHolder] = []
    var viewDismissalPublisher = PassthroughSubject<Bool, Never>()
    @Published var createdIngredient: Ingredient? {
        didSet {
            viewDismissalPublisher.send(true)
        }
    }
    private var cancellables = Set<AnyCancellable>()
    init() {
        getIngredients()
    }
    private func getIngredients() {
        recipeService.getIngredients()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("get ingredients publisher is finished")
                }
            }, receiveValue: { (result) in
                self.ingredients = result
            }).store(in: &cancellables)
    }
    func createIngredient() {
        let body: [String: Any] = ["name": "\(searchText)"]
        guard let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) else {
            // TODO make this an error
            return
        }
        recipeService.createIngredient(body: jsonDataBody)
            .sink(receiveCompletion: { completion in
                // TODO if I'm not doing anything with the finished case I guess I should
                // just change to be an if failure or something
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("publisher is finished")
                }
            }, receiveValue: { (result ) in
                self.createdIngredient = result
            }).store(in: &cancellables)
    }
}
