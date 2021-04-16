//
//  SelectTagsView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/4/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SelectTagsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel = SelectTagsViewModel()
    @Binding var selectedTags: [Tag]
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $viewModel.searchText, isSearching: $viewModel.isSearching)
                AddTagsButton(tags: viewModel.tags, searchText: viewModel.searchText,
                              didAdd: viewModel.createTag)
            // TODO clean it up so I'm not force unwrapping
                if let selected = selectedTags.map({ tag in
                                                    self.viewModel.selectables.first(where: {$0.name == tag.name })!}) {
                    SingleSelectListView(selected: selected, selectables: viewModel.selectables,
                                         searchText: viewModel.searchText,
                                         didSelect: didSelectTag(tag:))
                } else {
                    SingleSelectListView(selected: [], selectables: viewModel.selectables,
                                         searchText: viewModel.searchText,
                                         didSelect: didSelectTag(tag:))
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            }
            .onReceive(viewModel.createdTagPublisher) { tag in
                selectedTags.append(tag)
            }
        }
    }
    private func didSelectTag(tag: SelectableHolder) {
        if let tag = viewModel.tags.first(where: { $0.name == tag.name }) {
            if let index = selectedTags.firstIndex(of: tag) {
                selectedTags.remove(at: index)
            } else {
                selectedTags.append(tag)
            }
        }
    }
}
// TODO consider splitting this out to a helper class
private func tagsFiltered(tags: [Tag], filterText: String) -> [Tag] {
    return tags.filter({ "\($0.name)".contains(filterText) })
}

private struct AddTagsButton: View {
    var tags: [Tag]
    var searchText: String
    var didAdd: () -> Void
    var body: some View {
        if !searchText.isEmpty &&
            tagsFiltered(tags: tags, filterText: searchText).isEmpty {
            Button(action: {
                didAdd()
            }, label: {
                Text("Create \(searchText.capitalized)")
            })
        }
    }
}

struct SelectTagsView_Previews: PreviewProvider {
    @State static var tags: [Tag] = []
    static var previews: some View {
        SelectTagsView(selectedTags: $tags)
    }
}
