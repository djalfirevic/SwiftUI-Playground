//
//  CreatingAnimatedViews2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension CreatingAnimatedViews2 {
    struct TypewriterText: View, Animatable {
        @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
        @Environment(\.accessibilityReduceMotion) var accessibilityReduceMotion
        
        var string: String
        var count = 0
        
        var animatableData: Double {
            get { Double(count) }
            set { count = Int(max(0, newValue)) }
        }
        
        var body: some View {            
            if accessibilityVoiceOverEnabled || accessibilityReduceMotion {
                Text(string)
            } else {
                let stringToShow = String(string.prefix(count))
                
                ZStack {
                    Text(string)
                        .hidden()
                        .overlay(
                            Text(stringToShow),
                            alignment: .topLeading
                        )
                }
            }
        }
    }
}

struct CreatingAnimatedViews2: SelfCreatingView {
    @State private var value = 0
    let message = "This is a very long piece of text that appears letter by letter."

    var body: some View {
        VStack {
            TypewriterText(string: message, count: value)
                .frame(width: 300, alignment: .leading)

            Button("Type!") {
                withAnimation(.linear(duration: 2)) {
                    value = message.count
                }
            }

            Button("Reset") {
                value = 0
            }
        }
    }
}

struct CreatingAnimatedViews2_Previews: PreviewProvider {
    static var previews: some View {
        CreatingAnimatedViews2()
    }
}
