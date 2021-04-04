//
//  SingleSelectListView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 4/3/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct SingleSelectListView: View {
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
                        Text("Select")
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
