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
//    let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)
//    let userService = UserService()
    @StateObject var viewModel = ContentViewModel()

    
    var body: some View {
        
        if let _ = viewModel.token {
            if let _ = viewModel.user {
                HomeView()
            }
            else {
                AuthenticationView()
            }
            // need to add another case that verifies that the token is valid
//            userService.getMe() { (results : Result<User, Error>) in
//                switch(results) {
//                case .success(_):
//                    DispatchQueue.main.async {
//                        HomeView()
//                        // TODO redirect to the home screen
//                    }
//
//                case .failure(let error):
//                   AuthenticationView()
//                }
//            }
            
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
