//
//  ContentView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/16/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI
import KeychainSwift

struct ContentView: View {
    let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)

    
    var body: some View {
        if let token = keychain.get(KeychainKeys.token) {
            // need to add another case that verifies that the token is valid
            
            // also this should go to home screen
            Text("Home Screen coming soon")
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
