//
//  ImplementingARadialLayout.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension ImplementingARadialLayout {
    struct RadialLayout: Layout {
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
            proposal.replacingUnspecifiedDimensions()
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
            let radius = min(bounds.size.width, bounds.size.height) / 2
            let angle = Angle.degrees(360 / Double(subviews.count)).radians
            
            for (index, subview) in subviews.enumerated() {
                let viewSize = subview.sizeThatFits(.unspecified)
                
                let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
                let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
                
                let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
                subview.place(at: point, anchor: .center, proposal: .unspecified)
            }
        }
    }
}

struct ImplementingARadialLayout: SelfCreatingView {
    @State private var count = 8

    var body: some View {
        RadialLayout {
            ForEach(0..<count, id: \.self) { _ in
                Circle()
                    .frame(width: 32, height: 32)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Stepper("Count: \(count)", value: $count.animation(), in: 0...36)
                .padding()
        }
    }
}

struct ImplementingARadialLayout_Previews: PreviewProvider {
    static var previews: some View {
        ImplementingARadialLayout()
    }
}
