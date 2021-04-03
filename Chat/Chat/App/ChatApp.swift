//
//  ChatApp.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI
import Firebase

@main
struct ChatApp: App {
    
    // MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
