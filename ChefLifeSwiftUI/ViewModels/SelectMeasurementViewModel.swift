//
//  SelectMeasurementViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/1/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let recipeService = RecipeDataService()

class SelectMeasurementViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var measurements: [QuantityMeasurement] = [] {
        didSet {
            for measurement in measurements {
                selectables.append(SelectableHolder(selectable: measurement))
            }
        }
    }
    @Published var selectables: [SelectableHolder] = []
    private var cancellables = Set<AnyCancellable>()
    init() {
        getQuantityMeasurements()
    }
    private func getQuantityMeasurements() {
        recipeService.getMeasurements()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("publisher is finished")
                }
            }, receiveValue: { (result) in
                self.measurements = result
            }).store(in: &cancellables)
    }
}
