//
//  SelectMeasurementView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/31/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SelectMeasurementView: View {
    @ObservedObject var viewModel = SelectMeasurementViewModel()
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
            ScrollView {
                ForEach(viewModel.measurements) { measurement in
                    HStack {
                        Text("\(measurement.name)")
                    }
                }
            }
        }
    }
}

struct SelectMeasurementView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMeasurementView()
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    var body: some View {
        HStack {
            HStack {
                TextField("Search measurement", text: $searchText)
                    .padding(.leading, 24)
                    .padding(.vertical, -8)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding()
        }
    }
}
