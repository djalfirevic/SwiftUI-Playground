//
//  ActivityIndicatorView.swift
//  SwiftUIMovieDb
//
//  Created by Djuro Alfirevic on 23/05/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
}
