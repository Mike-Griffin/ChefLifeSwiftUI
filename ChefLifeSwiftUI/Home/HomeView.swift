//
//  HomeView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

fileprivate let userService = UserService()

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home")
            Button(action: {
                userService.logOut()
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
