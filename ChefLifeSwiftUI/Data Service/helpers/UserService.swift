//
//  TokenService.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import KeychainSwift

let apiService = RecipeApiService()

struct UserService {
    let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)

    func getToken(email: String, password: String, completion: @escaping (Result<Token, Error>) -> ()) {
        let body : [String : Any] = ["email": "\(email)", "password": "\(password)"]
        if let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) {
            apiService.apiRequest(request: "user/token/", body: jsonDataBody, httpMethod: "POST", headerFields: ["Content-Type": "application/json; charset=utf-8"], useToken: false) { (results : Result<Token, Error>) in
                switch(results) {
                case .success(let result):
                    DispatchQueue.main.async {
                        print("Great success!!")
                        print(result)
                        self.keychain.set(result.token, forKey: KeychainKeys.token)
                        completion(.success(result))
                        // TODO redirect to the home screen
                    }
                case.failure(let err):
                    print(err)
                    completion(.failure(err))
                }
            }
        }
    }
    
    func logOut() {
        keychain.delete(KeychainKeys.token)
    }
}
