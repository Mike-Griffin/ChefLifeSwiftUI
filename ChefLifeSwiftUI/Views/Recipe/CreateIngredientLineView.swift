//
//  CreateIngredientLineView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/31/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct CreateIngredientLineView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = CreateIngredientLineViewModel()
    @Binding var ingredientLines: [IngredientLine]
    @State var isSelectMeasurementShown = false
    @State var isSelectIngredientShown = false
    var body: some View {
        VStack {
            HStack {
                Text("Quantity")
                Spacer()
                TextField("Enter Quantity", text: $viewModel.quantity)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
            HStack {
                Text("Measurement")
                Spacer()
                Button(action: {
                    self.isSelectMeasurementShown.toggle()
                }, label: {
                    if let measurement = viewModel.selectedMeasurement {
                        Text("\(measurement.name)")
                    } else {
                        Text("Select Measurement")
                    }
                })
                .padding(.horizontal)
                .sheet(isPresented: $isSelectMeasurementShown) {
                    SelectMeasurementView(selectedMeasurement: $viewModel.selectedMeasurement)
                }
            }
            HStack {
                Text("Ingredient")
                Spacer()
                Button(action: {
                    self.isSelectIngredientShown.toggle()
                }, label: {
                    if let ingredient = viewModel.selectedIngredient {
                        Text("\(ingredient.name)")
                    } else {
                        Text("Select Ingredient")
                    }
                })
                .padding(.horizontal)
                .sheet(isPresented: $isSelectIngredientShown) {
                    SelectIngredientView(selectedIngredient: $viewModel.selectedIngredient)
                }

            }
//            .navigationTitle("\(recipe.title) Add Ingredient")
            Spacer()
            Button(action: {
                // TODO figure out a better way of setting the order / id
                // although this isn't bad, it doesn't allow for custom ordering
                if let newIngredient = viewModel.addIngredient(ingredientLines.count) {
                    ingredientLines.append(newIngredient)
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Save")
            })
        }
    }
}

// struct CreateIngredientLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateIngredientLineView()
//    }
// }
