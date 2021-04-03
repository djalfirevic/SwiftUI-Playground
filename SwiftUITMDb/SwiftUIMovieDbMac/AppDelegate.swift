//
//  AppDelegate.swift
//  SwiftUIMovieDbMac
//
//  Created by Djuro Alfirevic on 22/06/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Properties
    var window: NSWindow!

    // MARK: - NSApplicationDelegate
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSScrollView.swizzleScrollWhell()

        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

}
