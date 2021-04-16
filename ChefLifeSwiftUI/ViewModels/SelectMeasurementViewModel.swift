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
    @Published var createdMeasurement: QuantityMeasurement? {
        didSet {
            viewDismissalPublisher.send(true)
        }
    }
    @Published var selectables: [SelectableHolder] = []
    var viewDismissalPublisher = PassthroughSubject<Bool, Never>()
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
    func createMeasurement() {
        let body: [String: Any] = ["name": "\(searchText)"]
        guard let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) else {
            // TODO make this an error
            return
        }
        recipeService.createMeasurement(body: jsonDataBody)
            .sink(receiveCompletion: { completion in
                // TODO if I'm not doing anything with the finished case I guess I should
                // just change to be an if failure or something
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("create measurement publisher is finished")
                }
            }, receiveValue: { (result ) in
                self.createdMeasurement = result
            }).store(in: &cancellables)
    }
}
