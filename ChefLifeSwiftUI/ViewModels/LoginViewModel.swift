//
//  LoginViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/21/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

private let userService = UserApiService()

final class LoginViewModel: ObservableObject {
    let keychainService = KeychainService()

    @Published var token: Token? {
        didSet {
            if let token = token {
                keychainService.setToken(token: token.token)
                loginState = 1
                loadUser()
            }
        }
    }
    @Published var errorText: String? {
        didSet {
            if errorText != nil {
                loginState = 2
            }
        }
    }
    private var user: User? {
        didSet {
            if let user = user {
                if let savedName = keychainService.getName() {
                    if savedName != user.name {
                        keychainService.setName(name: user.name)
                    }
                } else {
                    keychainService.setName(name: user.name)
                }
                if let savedEmail = keychainService.getEmail() {
                    if savedEmail != user.email {
                        keychainService.setEmail(email: user.email)
                    }
                } else {
                    keychainService.setName(name: user.name)
                }
            }
        }
    }
    @Published var loginState: Int? = 0
    @Published var email: String = ""
    @Published var password: String = ""
    private var cancellable: AnyCancellable?
    func login() {
        guard email.count != 0, password.count != 0 else {
            return
        }

        cancellable = userService.getToken(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                // TODO make this failure case actually use the error
                case .failure: self.errorText = "Error logging in please try again"
                case .finished: print("publisher is finished")
                }
            }, receiveValue: { (result) in
                self.token = result
            })
    }
    func loadUser() {
        cancellable = userService.getMe()
            .sink(receiveCompletion: { _ in }, receiveValue: { user in
                self.user = user
            })
    }
}
