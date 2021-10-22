//
//  iOS15App.swift
//  Shared
//
//  Created by Meng To on 2021-06-16.
//

import SwiftUI

@main
struct iOS15App: App {
    @StateObject var model = Model() // Avoid calling multiple times, ensures that model initilize once and follows the lifecycle of the app
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
