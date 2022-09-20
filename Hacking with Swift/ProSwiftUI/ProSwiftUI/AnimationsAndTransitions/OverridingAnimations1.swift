//
//  OverridingAnimations1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension OverridingAnimations1 {
    func withMotionAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct OverridingAnimations1: SelfCreatingView {
    @State var scale = 1.0

    var body: some View {
        Button("Tap Me") {
            withMotionAnimation {
                scale += 1
            }
        }
        .scaleEffect(scale)
    }
}

struct OverridingAnimations1_Previews: PreviewProvider {
    static var previews: some View {
        OverridingAnimations1()
    }
}
