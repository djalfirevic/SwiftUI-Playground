//
//  AppDelegate.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import UIKit
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
}
