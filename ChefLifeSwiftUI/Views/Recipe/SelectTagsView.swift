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
        }
    }
    private func didSelectTag(tag: SelectableHolder) {
        // TODO add logic for deselecting
        if let tag = viewModel.tags.first(where: { $0.name == tag.name }) {
            selectedTags.append(tag)
        }
    }
}

struct SelectTagsView_Previews: PreviewProvider {
    @State static var tags: [Tag] = []
    static var previews: some View {
        SelectTagsView(selectedTags: $tags)
    }
}
