//
//  SignUpView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/17/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

private struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black)
                    TextField("Name", text: self.$viewModel.name)
                        .disableAutocorrection(true)
                }.padding(.vertical, 20)
                Divider()
                HStack(spacing: 15) {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    TextField("Email Address", text: self.$viewModel.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }.padding(.vertical, 20)
                Divider()
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    SecureField("Password", text: self.$viewModel.password)
                    Button(action: {
                        print("TODO make this hide the password")
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    })
                }.padding(.vertical, 20)
                Divider()
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    SecureField("Password", text: self.$viewModel.reenterPassword)
                    Button(action: {
                        print("TODO make this hide the password...or sync it up with the other one")
                    }, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    })
                }.padding(.vertical, 20)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            Text(viewModel.inlinePasswordError)
                .foregroundColor(.red)
                .offset(y: -60)
            NavigationLink(
                destination: HomeView()) {
                Text("SIGNUP")
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
            .simultaneousGesture(TapGesture().onEnded {
                viewModel.signUp()
            })
            .simultaneousGesture(LongPressGesture().onEnded {_ in
                viewModel.signUp()
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
