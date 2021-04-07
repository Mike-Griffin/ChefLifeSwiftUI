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
    @State private var isSelectTagsShown = false
    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $viewModel.title)
            }
            Divider()
            Spacer()
                .frame(height: 30)
            VStack {
                // TODO clean up this display
                HStack {
                    Text("Tags")
                    Spacer()
                    Button(action: {
                        isSelectTagsShown.toggle()
                    }, label: {
                        Text("Temp tags button")
                    })
                    .sheet(isPresented: $isSelectTagsShown, content: {
                        SelectTagsView(selectedTags: $viewModel.tags)
                    })
                }
                .padding()
                ForEach(viewModel.tags) { tag in
                    HStack {
                        Text(tag.name)
                    }
                }
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
                        Text(String(describing: ingredientLine.quantity))
                        Text(ingredientLine.measurement?.name ?? "Measurement Error")
                        Text(ingredientLine.ingredient?.name ?? "Ingredient Error")
                    }
                }
            }
            Spacer()
            Button("Save") {
                viewModel.createRecipe()
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
