//
//  ReduxApp.swift
//  Redux
//
//  Created by Djuro on 10/7/21.
//

import SwiftUI

@main
struct ReduxApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
