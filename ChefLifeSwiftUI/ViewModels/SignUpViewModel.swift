//
//  SignUpViewModel.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/23/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import Foundation
import Combine

enum PasswordStatus {
    case empty
    case tooWeak
    case notMatching
    case valid
}

private let apiService = RecipeApiService()
private let userService = UserApiService()

class SignUpViewModel: ObservableObject {
    let keychainService = KeychainService()

    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var reenterPassword = ""
    @Published var inlinePasswordError = ""
    @Published var formValid = false
    var createdUser: User?
    private var cancellables = Set<AnyCancellable>()
    var token: Token? {
        didSet {
            if let token = token {
                keychainService.setToken(token: token.token)
            }
        }
    }
    private var isNameEmptyPublisher: AnyPublisher<Bool, Never> {
        $name
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        // TODO enhance to make sure it's a valid email with @ and .
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }
    private var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    private var arePasswordsEqualPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $reenterPassword)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map { $0 == $1 }
            .eraseToAnyPublisher()
    }
    private var isPasswordStrongPublisher: AnyPublisher<Bool, Never> {
        // TODO enhance this to make sure it also checks for special characters / capital letters
        $password
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map {
                $0.count >= 6
            }
            .eraseToAnyPublisher()
    }
    private var isPasswordValidPublisher: AnyPublisher<PasswordStatus, Never> {
        Publishers.CombineLatest3(isPasswordEmptyPublisher, isPasswordStrongPublisher, arePasswordsEqualPublisher)
            .map {
                if $0 {
                    return PasswordStatus.empty
                }
                if !$1 {
                    return PasswordStatus.tooWeak
                }
                if !$2 {
                    return PasswordStatus.notMatching
                }
                return PasswordStatus.valid
            }
            .eraseToAnyPublisher()
    }
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isPasswordValidPublisher, isEmailValidPublisher, isNameEmptyPublisher)
            .map {
                $0 == .valid && $1 && !$2
            }
            .eraseToAnyPublisher()
    }
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formValid, on: self)
            .store(in: &cancellables)
        isPasswordValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { passwordStatus in
                switch passwordStatus {
                case .empty:
                    return "Password cannot be empty"
                case .tooWeak:
                    return "Password is too weak"
                case .notMatching:
                    return "Passwords do not match"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlinePasswordError, on: self)
            .store(in: &cancellables)
    }
    func signUp() {
        guard formValid else { return }
        let body: [String: Any] = ["name": "\(name)", "email": "\(email)", "password": "\(password)"]
        if let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) {
        apiService.combineRequest(endpoint: RecipeEndpoint.signup.rawValue, body: jsonDataBody,
                                  httpMethod: HttpMethod.post.rawValue,
                                  headerFields: [HeaderKeys.contentType.rawValue:
                                                    HeaderValues.JSONUTF8.rawValue],
                                  useToken: false)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    // TODO make this failure case actually use the error
                    case .failure(let error): print(error)
                    case .finished: print("publisher is finished")
                    }
                }, receiveValue: { (result) in
                    self.handleUser(result)
                }).store(in: &cancellables)
        }
    }
    func handleUser(_ user: User) {

        userService.getToken(email: user.email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                // TODO make this failure case actually use the error
                case .failure(let error): print(error)
                case .finished: print("publisher is finished")
                }
            }, receiveValue: { (result) in
                self.token = result
            }).store(in: &cancellables)
    }
    func storeToken(_ token: Token) {
        keychainService.setToken(token: token.token)
    }
}
