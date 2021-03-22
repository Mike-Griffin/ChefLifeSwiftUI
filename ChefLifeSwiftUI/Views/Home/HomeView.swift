//
//  HomeView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

//fileprivate let userService = UserService()

struct HomeView: View {
    // TODO move this to an appropriate view model
    let keychainService = KeychainService()
    
    var body: some View {
        VStack {
            Text("Home")
            Button(action: {
                keychainService.logout()
            }, label: {
                Text("Log Out")
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
