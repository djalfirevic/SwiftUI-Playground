//
//  CustomTimingCurves2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 08/09/2022.
//

import SwiftUI

extension Animation {
    static var easeInOutBack: Animation {
        Animation.timingCurve(0.5, -0.5, 0.5, 1.5)
    }

    static func easeInOutBack(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.5, -0.5, 0.5, 1.5, duration: duration)
    }
    
    static var easeInOutBackSteep: Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5)
    }

    static func easeInOutBackSteep(duration: TimeInterval = 0.2) -> Animation {
        Animation.timingCurve(0.7, -0.5, 0.3, 1.5, duration: duration)
    }
}

struct CustomTimingCurves2: SelfCreatingView {
    @State private var offset1 = -200.0
    @State private var offset2 = -200.0

    var body: some View {
        HStack(spacing: 50) {
            Text("Regular")
                .offset(y: offset1)
            
            Text("Steep")
                .offset(y: offset2)
        }
        .onTapGesture {
            withAnimation(.easeInOutBack(duration: 2).repeatForever(autoreverses: true)) {
                offset1 = 200
            }
            
            withAnimation(.easeInOutBackSteep(duration: 2).repeatForever(autoreverses: true)) {
                offset2 = 200
            }
        }
    }
}

struct CustomTimingCurves2_Previews: PreviewProvider {
    static var previews: some View {
        CustomTimingCurves2()
    }
}
