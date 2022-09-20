//
//  OverridingAnimations2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct MotionAnimationModifier<V: Equatable>: ViewModifier {
    @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion

    let animation: Animation?
    let value: V

    func body(content: Content) -> some View {
        if accessibilityReduceMotion {
            content
        } else {
            content.animation(animation, value: value)
        }
    }
}

extension View {
    func motionAnimation<V: Equatable>(_ animation: Animation?, value: V) -> some View {
        self.modifier(MotionAnimationModifier(animation: animation, value: value))
    }
}

struct OverridingAnimations2: SelfCreatingView {
    @State var scale = 1.0

    var body: some View {
        Button("Tap Me") {
            scale += 1
        }
        .scaleEffect(scale)
        .motionAnimation(.default, value: scale)
    }
}

struct OverridingAnimations2_Previews: PreviewProvider {
    static var previews: some View {
        OverridingAnimations2()
    }
}
