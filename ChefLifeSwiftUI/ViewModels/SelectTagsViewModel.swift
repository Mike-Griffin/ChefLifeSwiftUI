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
    @Published var createdTag: Tag? {
        didSet {
            if let tag = createdTag {
                tags.append(tag)
                createdTagPublisher.send(tag)
            }
        }
    }
    var createdTagPublisher = PassthroughSubject<Tag, Never>()
    @Published var tags: [Tag] = [] {
        didSet {
            for tag in tags {
                selectables.append(SelectableHolder(selectable: tag))
            }
        }
    }
    @Published var selectables: [SelectableHolder] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
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
    func createTag() {
        let body: [String: Any] = ["name": "\(searchText)"]
        guard let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) else {
            // TODO make this an error
            return
        }
        recipeService.createTag(body: jsonDataBody)
            .sink(receiveCompletion: { completion in
                // TODO if I'm not doing anything with the finished case I guess I should
                // just change to be an if failure or something
                switch completion {
                case .failure(let error): print(error)
                case .finished: print("create tag publisher is finished")
                }
            }, receiveValue: { (result) in
                self.createdTag = result
            }).store(in: &cancellables)
    }
}
