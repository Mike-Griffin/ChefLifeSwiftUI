//
//  KeychainService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/21/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import KeychainSwift

struct KeychainKeys {
    static let keyPrefix = "comedichoney_"
    static let token = "token"
}

struct KeychainService {
    let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)

    func logout() {
        keychain.delete(KeychainKeys.token)
    }
    
    func getToken() -> String? {
        return keychain.get(KeychainKeys.token)
    }
    
    func setToken(token: String) {
        keychain.set(token, forKey: KeychainKeys.token)
    }
}
