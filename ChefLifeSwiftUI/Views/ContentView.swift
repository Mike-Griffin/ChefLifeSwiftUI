//
//  ContentView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/16/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI
import KeychainSwift

@available(iOS 14.0, *)
struct ContentView: View {

    @StateObject var viewModel = ContentViewModel()

    
    var body: some View {
        
        if let _ = viewModel.token {
            if let _ = viewModel.user {
                NavigationView {
                    HomeView()
                }
            }
            else {
                AuthenticationView()
            }            
        }
        else {
            AuthenticationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
