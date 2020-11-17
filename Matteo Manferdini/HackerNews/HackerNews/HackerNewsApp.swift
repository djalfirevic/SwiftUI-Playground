//
//  HackerNewsApp.swift
//  HackerNews
//
//  Created by Matteo Manferdini on 15/10/2020.
//

import SwiftUI

@main
struct HackerNewsApp: App {
	var body: some Scene {
		WindowGroup {
			NavigationView {
				NewsView()
			}
		}
	}
}
