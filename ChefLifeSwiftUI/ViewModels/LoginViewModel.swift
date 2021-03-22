//
//  LoginViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/21/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

fileprivate let apiService = RecipeApiService()

final class LoginViewModel : ObservableObject {
    let keychainService = KeychainService()

    @Published var token : Token? {
        didSet {
            if let token = token {
                keychainService.setToken(token: token.token)
                loginState = 1
            }
        }
    }
    @Published var loginState : Int? = 0
    @Published var email : String = ""
    @Published var password : String = ""
    
    private var cancellable: AnyCancellable?
    
    func login() {
        print("Email: \(email)")
        print("Password: \(password)")
        guard email.count != 0, password.count != 0 else {
            return
        }
        let body : [String : Any] = ["email": "\(email)", "password": "\(password)"]
        if let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) {

            cancellable = apiService.combineRequest(endpoint: "user/token/", body: jsonDataBody, httpMethod: "POST", headerFields: ["Content-Type": "application/json; charset=utf-8"], useToken: false)
                .sink(receiveCompletion: { (error) in
                    print(error)
                    }, receiveValue: { (result) in
                        self.token = result
                    })
        }
    }
}
