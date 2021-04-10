//
//  SingleSelectListView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

// TODO consider renaming. Need to determine if this needs to be a seperate View
// The thing that is different is that the selected needs to be a single selectable in this view
// and an array in another. But I guess it doesn't hurt to make it an array in both.
// It's just a bit more code to write
struct SingleSelectListView: View {
    var selected: [SelectableHolder]
    var selectables: [SelectableHolder]
    var searchText: String
    var didSelect: (SelectableHolder) -> Void
    var body: some View {
        ScrollView {
            ForEach(searchText.isEmpty ? selectables :
                        selectables.filter({ "\($0.name)".contains(searchText) })) { selectable in
                HStack {
                    Text("\(selectable.name)")
                    Spacer()
                    Button(action: {
                        didSelect(selectable)
                    }, label: {
                        if selected.contains(where: { $0.name == selectable.name }) {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Text("Select")
                        }
                    })
                }
                .padding()
                Divider()
                    .padding(.leading)
            }
        }
    }
}

// struct SingleSelectListView_Previews: PreviewProvider {
//    @State static var selectables = []
//    @State static var searchText = ""
//    func didSelect(test: SelectableHolder) { }
//    static var previews: some View {
//        SingleSelectListView(selectables: $selectables, searchText: $searchText, didSelect: didSelect())
//    }
// }
