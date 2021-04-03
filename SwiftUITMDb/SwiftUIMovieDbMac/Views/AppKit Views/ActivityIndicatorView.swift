//
//  ActivityIndicatorView.swift
//  SwiftUIMovieDbMac
//
//  Created by Djuro Alfirevic on 20/06/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSProgressIndicator {
        let indicator = NSProgressIndicator()
        indicator.style = .spinning
        indicator.startAnimation(nil)
        return indicator
    }
    
    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
        
    }
}
