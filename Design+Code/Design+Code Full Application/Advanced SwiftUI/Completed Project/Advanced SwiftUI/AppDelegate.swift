//
//  AppDelegate.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/18/21.
//

import UIKit
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    public var coreDataContext: NSManagedObjectContext!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Your code here")
        coreDataContext = PersistenceController.shared.container.viewContext
        return true
    }
}
