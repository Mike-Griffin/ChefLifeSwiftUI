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
            if !viewModel.searchText.isEmpty &&
                measurementsFiltered(measurements: viewModel.measurements, filterText: viewModel.searchText).isEmpty {
                Button(action: {
                    print("add new boi")
                }, label: {
                    Text("Create \(viewModel.searchText.capitalized)")
                })
            }
            ScrollView {
                ForEach(viewModel.searchText.isEmpty ? viewModel.measurements :
                            measurementsFiltered(measurements: viewModel.measurements,
                                                 filterText: viewModel.searchText)) { measurement in
                    HStack {
                        Text("\(measurement.name)")
                        Spacer()
                    }
                    .padding()
                    Divider()
                        .padding(.leading)
                }
            }
        }
    }
}

private func measurementsFiltered(measurements: [QuantityMeasurement], filterText: String) -> [QuantityMeasurement] {
    return measurements.filter({ "\($0.name)".contains(filterText) })
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
