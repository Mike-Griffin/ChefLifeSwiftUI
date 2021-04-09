//
//  SelectMeasurementView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/31/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SelectMeasurementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var selectedMeasurement: QuantityMeasurement?
    @ObservedObject var viewModel = SelectMeasurementViewModel()
    var body: some View {
        VStack {
            SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
            AddMeasurementButton(measurements: viewModel.measurements, searchText: viewModel.searchText,
                                 didAdd: viewModel.createMeasurement)
            if let selected = viewModel.selectables.first(where: { $0.name == selectedMeasurement?.name }) {
                SingleSelectListView(selected: [selected], selectables: viewModel.selectables,
                                   searchText: viewModel.searchText,
                                 didSelect: didSelectMeasurement(measurement:))
            } else {
                SingleSelectListView(selected: [], selectables: viewModel.selectables,
                                   searchText: viewModel.searchText,
                                 didSelect: didSelectMeasurement(measurement:))
            }
        }
        .onReceive(viewModel.viewDismissalPublisher) { shouldDismiss in
            if shouldDismiss {
                selectedMeasurement = viewModel.createdMeasurement
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    private func didSelectMeasurement(measurement: SelectableHolder) {
        selectedMeasurement = viewModel.measurements.first(where: { $0.name == measurement.name })
        self.presentationMode.wrappedValue.dismiss()
    }
}

private func measurementsFiltered(measurements: [QuantityMeasurement], filterText: String) -> [QuantityMeasurement] {
    return measurements.filter({ "\($0.name)".contains(filterText) })
}

struct SelectMeasurementView_Previews: PreviewProvider {
    @State static var measurement: QuantityMeasurement? = QuantityMeasurement(name: "testing", id: 1)
    static var previews: some View {
        SelectMeasurementView(selectedMeasurement: self.$measurement )
    }
}

private struct AddMeasurementButton: View {
    var measurements: [QuantityMeasurement]
    var searchText: String
    var didAdd: () -> Void
    var body: some View {
        if !searchText.isEmpty &&
            measurementsFiltered(measurements: measurements, filterText: searchText).isEmpty {
            Button(action: {
                didAdd()
            }, label: {
                Text("Create \(searchText.capitalized)")
            })
        }
    }
}
