//
//  UnderstandingIdentity5.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension View {
    func hidden(_ hidden: Bool) -> some View {
        self.opacity(hidden ? 0 : 1)
    }
}

extension UnderstandingIdentity5 {
    struct ExampleView: View {
        @State private var counter = 0
        let scale: Double

        var body: some View {
            Button("Tap Count: \(counter)") {
                counter += 1
            }
            .scaleEffect(scale)
        }
    }
}

struct UnderstandingIdentity5: SelfCreatingView {
    @State private var shouldHide = false

    var body: some View {
        VStack {
            if shouldHide {
                ExampleView(scale: 1)
                    .hidden()
            } else {
                ExampleView(scale: 1)
            }

            Button("Toggle") {
                withAnimation {
                    shouldHide.toggle()
                }
            }
        }
    }
}

struct UnderstandingIdentity5_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingIdentity5()
    }
}
