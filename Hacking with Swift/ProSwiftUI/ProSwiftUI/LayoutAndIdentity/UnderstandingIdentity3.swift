//
//  UnderstandingIdentity3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension UnderstandingIdentity3 {
    struct ExampleView: View {
        @State private var counter = 0
        
        var body: some View {
            Button("Tap Count: \(counter)") {
                counter += 1
            }
        }
    }
}

struct UnderstandingIdentity3: SelfCreatingView {
    @State private var scaleUp = false

    var body: some View {
        VStack {
            if scaleUp {
                ExampleView()
                    .scaleEffect(2)
            } else {
                ExampleView()
            }

            Toggle("Scale Up", isOn: $scaleUp.animation())
        }
        .padding()
    }
}


struct UnderstandingIdentity3_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingIdentity3()
    }
}
