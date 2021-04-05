//
//  SelectTagsViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/4/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let recipeService = RecipeDataService()


class SelectTagsViewModel: ObservableObject {
    @Published var tags: [Tag] = [] {
        didSet {
            for tag in tags {
                selectables.append(SelectableHolder(selectable: tag))
            }
        }
    }
    @Published var selectables: [SelectableHolder] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()
    init() {
        getTags()
    }
    private func getTags() {
        recipeService.getTags()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("get tags publisher is finished")
                }
            }, receiveValue: { (result) in
                self.tags = result
            }).store(in: &cancellables)
    }
}
