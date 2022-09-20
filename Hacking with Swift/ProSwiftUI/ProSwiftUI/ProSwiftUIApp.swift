//
//  ProSwiftUIApp.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

@main
struct ProSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    // Force our navigation bar to never let content flow under it.
    // This is particularly important for the drawing chapters.
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
