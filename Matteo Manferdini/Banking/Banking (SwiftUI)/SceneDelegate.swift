//
//  SceneDelegate.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 11/03/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	let stateController = StateController()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		let contentView = AccountsView()
			.environmentObject(stateController)
		if let windowScene = scene as? UIWindowScene {
			let window = UIWindow(windowScene: windowScene)
			window.rootViewController = UIHostingController(rootView: contentView)
			self.window = window
			window.makeKeyAndVisible()
		}
	}
}

