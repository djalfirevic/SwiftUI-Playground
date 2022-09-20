//
//  CreatingAnimatedViews1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension CreatingAnimatedViews1 {
    struct CountingText: View, Animatable {
        var value: Double
        var fractionLength = 8
        
        var animatableData: Double {
            get { value }
            set { value = newValue }
        }
        
        var body: some View {
            Text(value.formatted(.number.precision(.fractionLength(fractionLength))))
        }
    }
}

struct CreatingAnimatedViews1: SelfCreatingView {
    @State private var value = 0.0

    var body: some View {
        CountingText(value: value)
            .onTapGesture {
                withAnimation(.linear) {
                    value = Double.random(in: 1...1000)
                }
            }
    }
}

struct CreatingAnimatedViews1_Previews: PreviewProvider {
    static var previews: some View {
        CreatingAnimatedViews1()
    }
}
