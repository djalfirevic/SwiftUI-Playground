//
//  Challenge1App.swift
//  Challenge1
//
//  Created by Quinn McHenry on 8/26/21.
//

import SwiftUI

@main
struct Challenge1App: App {
    static let baseTime = Calendar.current.date(bySettingHour: 23, minute: 15, second: 0, of: Date()) ?? Date()
    @State private var bedtime = Self.baseTime
    @State private var wakeUp = Self.baseTime.addingTimeInterval(8*3600)

    var body: some Scene {
        WindowGroup {
            ContentView(bedtime: $bedtime, wakeUp: $wakeUp)
        }
    }
}
