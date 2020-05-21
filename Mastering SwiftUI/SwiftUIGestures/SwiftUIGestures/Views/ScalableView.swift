//
//  ScalableView.swift
//  SwiftUIGestures
//
//  Created by Simon Ng on 4/12/2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import SwiftUI

struct ScalableView<Content>: View where Content: View {
    @GestureState private var scaleFactor: CGFloat = 1.0
    var content: () -> Content
    
    var body: some View {
        content()
            .scaleEffect(scaleFactor)
            .animation(.default)
            .gesture(MagnificationGesture()
                .updating($scaleFactor, body: { (value, state, transaction) in
                    state = value
                })
            )
    }
}

struct ScalableView_Previews: PreviewProvider {
    static var previews: some View {
        ScalableView() {
            Image(systemName: "headphones")
                .font(.system(size: 100))
                .foregroundColor(.purple)
        }
    }
}
