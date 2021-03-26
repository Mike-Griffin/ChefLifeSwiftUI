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
fileprivate let apiService = RecipeApiService()
fileprivate let keychainService = KeychainService()

final class ContentViewModel : ObservableObject {
    @Published var token : String?
    @Published var user : User? {
        didSet {
            if let user = user {
                if let savedName = keychainService.getName() {
                    if savedName != user.name {
                        keychainService.setName(name: user.name)
                    }
                }
                else {
                    keychainService.setName(name: user.name)
                }
                
                if let savedEmail = keychainService.getEmail() {
                    if savedEmail != user.email {
                        keychainService.setEmail(email: user.email)
                    }
                }
                else {
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
    
    fileprivate func setupPublisher() {
        cancellable = apiService.combineRequest(endpoint: RecipeEndpoint.me.rawValue, body: nil, httpMethod: HttpMethod.get.rawValue, headerFields: nil)
            .sink(receiveCompletion: { _ in }) { user in
                self.user = user
            }
    }
}
