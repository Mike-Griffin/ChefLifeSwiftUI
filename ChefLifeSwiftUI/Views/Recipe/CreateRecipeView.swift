//
//  CreateRecipeView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/26/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct CreateRecipeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = CreateRecipeViewModel()
    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $viewModel.title)
            }
            Divider()
            Spacer()
                .frame(height: 30)
            HStack {
                Text("Tags")
            }
            Spacer()
                .frame(height: 30)
            VStack {
                Text("Ingredients")
                NavigationLink(destination: CreateIngredientLineView(ingredientLines: $viewModel.ingredientLines)) {
                        Text("Add Ingredient")
                    }
                ForEach(viewModel.ingredientLines) { ingredientLine in
                    HStack {
                        Text(ingredientLine.ingredient?.name ?? "Name Error")
                    }
                }
            }
            Spacer()
            Button("Save") {
                print("printing")
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .navigationTitle("Create Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
