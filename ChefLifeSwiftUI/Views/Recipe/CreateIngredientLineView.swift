//
//  CreateIngredientLineView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/31/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct CreateIngredientLineView: View {
    @ObservedObject var viewModel = CreateIngredientLineViewModel()
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
                NavigationLink(destination: SelectMeasurementView()) {
                    Text("Select Measurement")
                }
                .padding(.horizontal)
            }
            HStack {
                Text("Ingredient")
                Spacer()
                NavigationLink(destination: SelectMeasurementView()) {
                    Text("TODO Ingredient")
                }
                .padding(.horizontal)
            }
            Spacer()
        }
    }
}

struct CreateIngredientLineView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIngredientLineView()
    }
}
