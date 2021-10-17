//
//  SignInWithAppleButton.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/6/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct SignInWithAppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    func makeUIView(context: Context) -> UIViewType {
        return ASAuthorizationAppleIDButton(type: .continue, style: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
