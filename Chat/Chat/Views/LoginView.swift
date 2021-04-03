//
//  LoginView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    @State private var email = ""
    @State private var password = ""
    @ObservedObject private var sessionStore = SessionStore()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                FullWidthButtonView(label: "Log in", action: {
                    sessionStore.signIn(email: email, password: password)
                })
                
                FullWidthButtonView(label: "Sign up", action: {
                    sessionStore.signUp(email: email, password: password)
                })
            }
            .padding(.horizontal)
            .navigationBarTitle("Welcome")
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
