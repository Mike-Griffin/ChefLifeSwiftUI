//
//  LoginView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/17/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var hidePassword = true
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    TextField("Email Address", text: self.$viewModel.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                }.padding(.vertical, 20)
                Divider()
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    if self.hidePassword {
                        SecureField("Password", text: self.$viewModel.password)
                        Button(action: {
                            hidePassword = false
                        }, label: {
                            Image(systemName: "eye")
                                .foregroundColor(.black)
                        })
                    } else {
                        TextField("Password", text: self.$viewModel.password)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Button(action: {
                            hidePassword = true
                        }, label: {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.black)
                        })
                    }
                }.padding(.vertical, 20)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            if let errorText = viewModel.errorText {
                Text(errorText)
                    .foregroundColor(Color.red)
                    .offset(y: -60)
            }
            NavigationLink(destination: HomeView(), tag: 1, selection: $viewModel.loginState) {
                VStack {
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                .background(
                    Color("main-light"))
                .cornerRadius(8)
                .offset(y: -40)
                .padding(.bottom, -40)
                .shadow(radius: 15)
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.login()
                })
                .simultaneousGesture(LongPressGesture().onEnded {_ in
                    viewModel.login()
                })
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
