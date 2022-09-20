//
//  UnderstandingIdentity4.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension UnderstandingIdentity4 {
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

struct UnderstandingIdentity4: SelfCreatingView {
    @State private var scaleUp = false

    var exampleView: some View {
        if scaleUp {
            return ExampleView(scale: 2)
        } else {
            return ExampleView(scale: 1)
        }
    }

    var body: some View {
        VStack {
            exampleView

            Toggle("Scale Up", isOn: $scaleUp.animation())
        }
        .padding()
    }
}

struct UnderstandingIdentity4_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingIdentity4()
    }
}
