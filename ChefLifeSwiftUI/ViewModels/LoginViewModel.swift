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
    @Published var errorText : String? {
        didSet {
            if let _ = errorText {
                loginState = 2
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
        if let loginState = loginState {
            print("Login state: \(loginState)")
        }
        guard email.count != 0, password.count != 0 else {
            return
        }
        let body : [String : Any] = ["email": "\(email)", "password": "\(password)"]
        if let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) {

            cancellable = apiService.combineRequest(endpoint: RecipeEndpoint.token.rawValue, body: jsonDataBody, httpMethod: HttpMethod.post.rawValue, headerFields: [HeaderKeys.ContentType.rawValue: HeaderValues.JSONUTF8.rawValue], useToken: false)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    // TODO make this failure case actually use the error 
                    case .failure(let error): self.errorText = "Error logging in please try again"
                    case .finished: print("publisher is finished")
                    }
                }, receiveValue: { (result) in
                    self.token = result
                })
//                .sink(receiveCompletion: { (error) in
//
//                    if error != nil {
//                        print("Error")
//                        print(error)
//                        self.errorText = "Error logging in please try again"
//                    }
//                }, receiveValue: { (result) in
//                    self.token = result
//                })
        }
    }
}
