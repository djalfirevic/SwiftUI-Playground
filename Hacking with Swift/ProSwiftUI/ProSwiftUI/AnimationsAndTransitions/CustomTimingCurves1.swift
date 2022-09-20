//
//  CustomTimingCurves.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension Animation {
    static var edgeBounce: Animation {
        Animation.timingCurve(0, 1, 1, 0)
    }
    
    static func edgeBounce(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0, 1, 1, 0, duration: duration)
    }
}

struct CustomTimingCurves1: SelfCreatingView {
    @State private var offset = -200.0

    var body: some View {
        Text("Hello, world!")
            .offset(y: offset)
            .animation(.edgeBounce(duration: 2).repeatForever(autoreverses: true), value: offset)
            .onTapGesture {
                offset = 200
            }
    }
}

struct CustomTimingCurves_Previews: PreviewProvider {
    static var previews: some View {
        CustomTimingCurves1()
    }
}
