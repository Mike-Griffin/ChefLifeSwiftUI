//
//  MenuView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/26/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    let keychainService = KeychainService()

    var body: some View {
        ZStack {
            Color("main-dark")
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                HStack {
                    NavigationLink(
                        destination: AuthenticationView()) {
                            Text("Logout")
                    }
                }
                Spacer()
            }
            .simultaneousGesture(TapGesture().onEnded {
                keychainService.logout()
            })
            .simultaneousGesture(LongPressGesture().onEnded { _ in
                keychainService.logout()
            })
    }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
