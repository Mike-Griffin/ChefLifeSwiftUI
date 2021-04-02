//
//  ContentViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

// it seems like it's common to make this a global singleton. Look into best practice around that
// TODO for now I'm making it private
private let userApiService = UserDataService()
private let keychainService = KeychainService()

final class ContentViewModel: ObservableObject {
    @Published var token: String?
    @Published var user: User? {
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
    private var cancellable: AnyCancellable?
    init() {
        token = keychainService.getToken()
        if token != nil {
            setupPublisher()
        }
    }
    private func setupPublisher() {
        cancellable = userApiService.getMe()
            .sink(receiveCompletion: {_ in }, receiveValue: { user in
                self.user = user
            })
    }
}
