//
//  SessionStore.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import Foundation
import FirebaseAuth

final class SessionStore: ObservableObject {
    
    // MARK: - Properties
    @Published var session: User?
    @Published var isAnonymous: Bool = false
    private var handle: AuthStateDidChangeListenerHandle?
    private let authRef = Auth.auth()
    
    // MARK: - Public API
    func listen() {
        handle = authRef.addStateDidChangeListener({(auth, user) in
            if let user = user {
                self.isAnonymous = false
                self.session =  User(uid: user.uid, email: user.email!)
            } else {
                self.isAnonymous = true
                self.session = nil
            }
        })
    }
    
    func signIn(email: String, password: String) {
        authRef.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error logging in", error.localizedDescription)
            }
        }
    }
    
    func signUp(email: String, password: String) {
        authRef.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error creating user", error.localizedDescription)
            }
        }
    }
    
    func signOut() -> Bool {
        do {
            try authRef.signOut()
            self.session = nil
            self.isAnonymous = true
            return true
        } catch {
            return false
        }
    }
    
    func unbind() {
        guard let handle = handle else { return }
        
        authRef.removeStateDidChangeListener(handle)
    }
    
}
