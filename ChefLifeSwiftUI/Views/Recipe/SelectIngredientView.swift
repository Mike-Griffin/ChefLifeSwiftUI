//
//  SelectIngredientView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SelectIngredientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = SelectIngredientViewModel()
    @Binding var selectedIngredient: Ingredient?
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
            AddIngredientButton(ingredients: viewModel.ingredients, searchText: viewModel.searchText,
                                didAdd: viewModel.createIngredient)
            if let selected = viewModel.selectables.first(where: { $0.name == selectedIngredient?.name }) {
                SingleSelectListView(selected: [selected], selectables: viewModel.selectables,
                                   searchText: viewModel.searchText,
                                 didSelect: didSelectIngredient(ingredient:))
            } else {
                SingleSelectListView(selected: [], selectables: viewModel.selectables,
                                   searchText: viewModel.searchText,
                                 didSelect: didSelectIngredient(ingredient:))
            }
        }
        .onReceive(viewModel.viewDismissalPublisher) { shouldDismiss in
            if shouldDismiss {
                selectedIngredient = viewModel.createdIngredient
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    private func didSelectIngredient(ingredient: SelectableHolder) {
        selectedIngredient = viewModel.ingredients.first(where: { $0.name == ingredient.name })
        self.presentationMode.wrappedValue.dismiss()
    }
}

// TODO consider splitting this out to a helper class
private func ingredientsFiltered(ingredients: [Ingredient], filterText: String) -> [Ingredient] {
    return ingredients.filter({ "\($0.name)".contains(filterText) })
}

// struct SelectIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectIngredientView(ingredientLine: IngredientLine(measurement: nil, quantity: nil))
//    }
// }

private struct AddIngredientButton: View {
    var ingredients: [Ingredient]
    var searchText: String
    var didAdd: () -> Void
    var body: some View {
        if !searchText.isEmpty &&
            ingredientsFiltered(ingredients: ingredients, filterText: searchText).isEmpty {
            Button(action: {
                didAdd()
            }, label: {
                Text("Create \(searchText.capitalized)")
            })
        }
    }
}
