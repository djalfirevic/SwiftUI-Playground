//
//  ContentView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @ObservedObject private var sessionStore = SessionStore()
    
    // MARK: - Initializer
    init() {
        sessionStore.listen()
    }
    
    // MARK: - Body
    var body: some View {
        ChatListView()
            .fullScreenCover(isPresented: $sessionStore.isAnonymous, content: {
                LoginView()
            })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
