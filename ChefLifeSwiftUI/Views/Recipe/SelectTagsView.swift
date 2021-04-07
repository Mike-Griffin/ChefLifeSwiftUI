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
            SingleSelectListView(selectables: viewModel.selectables, searchText: viewModel.searchText,
                                 didSelect: didSelectTag(tag:))
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
