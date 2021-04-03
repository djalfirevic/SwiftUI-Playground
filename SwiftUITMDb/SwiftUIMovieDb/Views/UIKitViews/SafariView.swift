//
//  SafariView.swift
//  SwiftUIMovieDb
//
//  Created by Djuro Alfirevic on 24/05/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
}
