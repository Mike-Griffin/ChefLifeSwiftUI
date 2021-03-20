//
//  LoginView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/17/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI
import KeychainSwift

let apiService = RecipeApiService()


struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var hidePassword = true
    let keychain = KeychainSwift(keyPrefix: KeychainKeys.keyPrefix)
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Email Address", text: self.$email)
                        .autocapitalization(.none)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    
                    if self.hidePassword {
                        
                        SecureField("Password", text: self.$password)
                        
                        Button(action: {
                            hidePassword = false
                        }) {
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                        }
                    }
                    else {
                        TextField("Password", text: self.$password)
                            .autocapitalization(.none)
                        Button(action: {
                            hidePassword = true
                        }) {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.black)
                        }
                    }
                }.padding(.vertical, 20)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Button(action: {
                self.handleLogin()
            }) {
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
            }.background(
                Color("main-light")
            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 15)
        }
    }
    
    // decide if I should move this into another file...MVVM?
    fileprivate func handleLogin() {
        //print("do the login thing")
        let body : [String : Any] = ["email": "\(email)", "password": "\(password)"]
        if let jsonDataBody = try? JSONSerialization.data(withJSONObject: body) {
            apiService.apiRequest(request: "user/token/", body: jsonDataBody, httpMethod: "POST", headerFields: ["Content-Type": "application/json; charset=utf-8"], useToken: false) { (results : Result<Token, Error>) in
                switch(results) {
                case .success(let result):
                    DispatchQueue.main.async {
                        print("Great success!!")
                        print(result)
                        self.keychain.set(result.token, forKey: KeychainKeys.token)
                        
                        // TODO redirect to the home screen
                    }
                case.failure(let err):
                    print(err)
                
                }
            }
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
