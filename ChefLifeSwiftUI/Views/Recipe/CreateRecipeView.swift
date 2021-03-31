//
//  CreateRecipeView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/26/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct CreateRecipeView: View {
    @State var email = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $email)
            }
            Divider()
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
