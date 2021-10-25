//
//  RangeSelector.swift
//  Challenge1
//
//  Created by Quinn McHenry on 9/29/21.
//

import SwiftUI

struct RangeSelector: View {
    @Binding var length: Angle
    @Binding var rotation: Angle
    let width: CGFloat
    @State private var dragging: Dragging?
    @State private var draggingOffset: Angle = .zero
    private let touchWidth = 8.0 // +/- degrees establishing endcap drag zones

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                RangeShape(length: length, width: width)
                    .rotationEffect(rotation)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let angle = CGPoint(x: proxy.size.width/2, y: proxy.size.height/2).angle(to: gesture.location)
                                if dragging == nil {
                                    if abs((angle - rotation).degrees.remainder(dividingBy: 360.0)) < touchWidth {
                                        dragging = .bed
                                        draggingOffset = .zero
                                    } else if abs((angle - rotation - length).degrees.remainder(dividingBy: 360.0)) < touchWidth {
                                        dragging = .bell
                                        draggingOffset = .zero
                                    } else {
                                        dragging = .body
                                        draggingOffset = angle - rotation
                                    }
                                }
                                switch dragging {
                                case .body:
                                    rotation = angle - draggingOffset
                                case .bed:
                                    length += rotation - angle
                                    rotation = angle
                                case .bell:
                                    length = angle - rotation
                                default:
                                    break
                                }
                            }
                            .onEnded { gesture in
                                dragging = nil
                            }
                    )

                Image(systemName: "bed.double.fill")
                    .foregroundColor(Color("secondary"))
                    .offset((Angle(degrees: 90) - rotation).point(forLength: (proxy.size.width - width)/2, offset: .zero).size)

                Image(systemName: "bell.fill")
                    .foregroundColor(Color("secondary"))
                    .offset((Angle(degrees: 90) - length - rotation).point(forLength: (proxy.size.width - width)/2, offset: .zero).size)

            }
        }
    }

    enum Dragging {
        case bed
        case body
        case bell
    }
}

struct RangeShape: Shape {
    let length: Angle
    let width: CGFloat

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.midX, rect.midY)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: .zero, endAngle: length, clockwise: false)
        path.addArc(center: (Angle(degrees: 90) - length).point(forLength: radius - width/2, offset: center), radius: width/2, startAngle: length, endAngle: length + Angle(degrees: 180), clockwise: false)
        path.addArc(center: center, radius: radius - width, startAngle: length, endAngle: .zero, clockwise: true)
        path.addArc(center: Angle(degrees: 90).point(forLength: radius - width/2, offset: center), radius: width/2, startAngle: Angle(degrees: 180), endAngle: .zero, clockwise: false)
        return path
    }


}

extension Angle {
    func point(forLength length: CGFloat, offset: CGPoint = .zero) -> CGPoint {
        let s = sin(radians)
        let c = cos(radians)
        return CGPoint(x: length * CGFloat(s) + offset.x, y: length * CGFloat(c) + offset.y)
    }
}

extension CGPoint {
    var size: CGSize {
        CGSize(width: x, height: y)
    }
}

struct RangeSelector_Previews: PreviewProvider {
    static var previews: some View {
        preview(degrees: 45)
        preview(degrees: 90)
        preview(degrees: 180)
        preview(degrees: 270)
        preview(degrees: 270, width: 10)
    }

    static func preview(degrees: Double, width: Double = 50, rotation: Double = 0) -> some View {
        RangeSelector(length: .constant(Angle(degrees: degrees)), rotation: .constant(Angle(degrees: rotation)), width: width)
            .padding()
            .frame(width: 350, height: 350)
            .previewLayout(.sizeThatFits)
    }
}
