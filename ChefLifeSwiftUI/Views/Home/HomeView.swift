//
//  HomeView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let keychainService = KeychainService()
    var body: some View {
        VStack {
            Text("Welcome Home \(keychainService.getName() ?? "")")
            Spacer()
            VStack {
                NavigationLink(
                    destination: CreateRecipeView(),
                    label: {
                        HStack {
                            Text("Create a New Recipe")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        }
                        .padding()

                    })
            }
            .background(Color("main-light"))
            .cornerRadius(25)
            .shadow(radius: 5)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading ) {
                NavigationLink(
                    destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: MenuView()) {
                    Image(systemName: "line.horizontal.3")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
