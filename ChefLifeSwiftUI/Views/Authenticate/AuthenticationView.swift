//
//  AuthenticationView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/18/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        ZStack {
            Color("main-dark")
                .edgesIgnoringSafeArea(.all)
            
            if UIScreen.main.bounds.height > 800 {
                AuthenticationFormView()
            }
            else {
                ScrollView(.vertical, showsIndicators: false) {
                    AuthenticationFormView()
                }
            }
        }
    }
}

struct AuthenticationFormView : View {
    @State var index = 0
    
    var body : some View {
        VStack {
            Image("chef")
                .resizable()
                .frame(width: 200, height: 180)
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        self.index = 0
                    }
                }) {
                    Text("Login")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }.background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                        self.index = 1
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                }
                .background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
            }
            .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            
            if self.index == 0 {
                LoginView()
            }
            else {
                SignUpView()
            }
            
            if self.index == 0 {
                Button(action: {
                    
                }) {
                    Text("Forget Password?")
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
