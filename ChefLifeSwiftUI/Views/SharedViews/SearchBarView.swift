//
//  SearchBar.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var body: some View {
        HStack {
            HStack {
                TextField("Search measurement", text: $searchText)
                    .padding(.leading, 24)
                    .padding(.vertical, -8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding()
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = "text"
    @State static var isSearching = true
    static var previews: some View {
        SearchBarView(searchText: $searchText, isSearching: $isSearching)
    }
}
