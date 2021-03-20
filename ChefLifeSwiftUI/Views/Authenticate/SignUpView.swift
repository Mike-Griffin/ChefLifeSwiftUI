//
//  SignUpView.swift
//  ChefLifeSwiftUI
//
//  Created by Mike Griffin on 3/17/21.
//  Copyright © 2021 Mike Griffin. All rights reserved.
//

import SwiftUI

fileprivate struct CShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}

struct SignUpView: View {
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var reenterPassword = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 15) {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black)
                    
                    TextField("Name", text: self.$name)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    
                    TextField("Email Address", text: self.$email)
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$password)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    Image(systemName: "lock")
                        .resizable()
                        .frame(width: 15, height: 18)
                        .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$reenterPassword)
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "eye")
                            .foregroundColor(.black)
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
                
            }) {
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
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
