//
//  ContentViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/20/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine
import KeychainSwift

// it seems like it's common to make this a global singleton. Look into best practice around that
// TODO for now I'm making it private
fileprivate let apiService = RecipeApiService()

final class ContentViewModel : ObservableObject {
    @Published var token : String?
    @Published var user : User?
    
//    private var apiPublisher: AnyPublisher<User, Error>?
//
//    private var apiCancellable: AnyCancellable? {
//        willSet {
//            apiCancellable?.cancel()
//        }
//    }
    
    private var cancellable: AnyCancellable?
    
    init() {
        let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)
        token = keychain.get(KeychainKeys.token)
        setupPublisher()
    }
    
    fileprivate func setupPublisher() {
        cancellable = apiService.combineRequest(endpoint: "user/me/", body: nil, httpMethod: "GET", headerFields: nil)
            .sink(receiveCompletion: { _ in }) { user in
                self.user = user
            }
    }
}
