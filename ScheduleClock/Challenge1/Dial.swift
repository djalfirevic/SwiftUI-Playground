//
//  Dial.swift
//  Challenge1
//
//  Created by Quinn McHenry on 9/14/21.
//

import SwiftUI

let ringWidth = 70.0

struct Dial: View {
    @Binding var rotation: Angle
    @State private var length = Angle(degrees: 75)

    let hashes: [Hashmark] = {
        (0..<(24*4)).map { Hashmark(id: $0)}
    }()

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Circle()
                    .scaledToFit()
                    .foregroundColor(Color("dial"))
                    .padding()

                Circle()
                    .scaledToFit()
                    .foregroundColor(Color("backgroundCard"))
                    .padding(ringWidth)

                ZStack {
                    ForEach(hashes) { hash in
                        hash.path(in: proxy.size)
                            .stroke(Color("secondary"), lineWidth: 1)
                        hash.label(in: proxy.size)
                        hash.flourish(in: proxy.size)
                    }
                }

                RangeSelector(length: $length, rotation: $rotation, width: ringWidth - 31)
                    .foregroundColor(Color("backgroundCard"))
                    .padding(24)
            }
            .foregroundColor(.white)
        }
    }
}

struct Hashmark: Identifiable {
    let id: Int

    var isHour: Bool {
        id.isMultiple(of: 4)
    }

    var hour: Int {
        id / 4
    }

    var hashLength: Double {
        isHour ? 12 : 4
    }

    var angle: Angle {
        Angle(degrees: 180.0 - 360.0 / 24 / 4 * Double(id))
    }

    func startPoint(in rect: CGSize, inset: Double = 0, forPath: Bool = false) -> CGSize {
        let angle = angle
        let radius = (rect.width - ringWidth * 2 - inset) / 2 * 1.0
        let x = sin(angle.radians) * radius + (forPath ? rect.width / 2.0 : 0.0)
        let y = cos(angle.radians) * radius + (forPath ? rect.height / 2.0 : 0.0)
        print("id: \(id) -> x: \(x), y: \(y)")
        return .init(width: x, height: y)
    }

    func path(in size: CGSize) -> Path {
        Path { path in
            path.move(to: CGPoint(startPoint(in: size, inset: 10, forPath: true)))
            path.addLine(to: CGPoint(startPoint(in: size, inset: 10 + hashLength, forPath: true)))
        }
    }

    @ViewBuilder
    func label(in size: CGSize) -> some View {
        if isHour && hour.isMultiple(of: 2) {
            Group {
                Text(hourCopy).font(.callout) + Text(hourSuffix).font(.caption2)
            }
            .foregroundColor(Color(hour.isMultiple(of: 6) ? "primary" : "secondary"))
            .offset(startPoint(in: size, inset: 48))
            .padding(.leading, hour == 18 ? 10 : 0)
            .padding(.trailing, hour == 6 ? 10 : 0)
        }
    }

    @ViewBuilder
    func flourish(in size: CGSize) -> some View {
        if isHour && hour.isMultiple(of: 12) {
            ZStack {
                Text(hour == 0 ? "✨" : "☀️")
                    .font(.system(size: 14))
                if hour == 0 {
                    Color.teal
                        .mask(Text("✨"))
                }
            }
            .font(.system(size: 14))
            .offset(startPoint(in: size, inset: 90))
        }
    }

    var hourCopy: String {
        let hourRaw = hour % 12
        let humanHour = hourRaw == 0 ? 12 : hourRaw
        return "\(humanHour)"
    }

    var hourSuffix: String {
        guard hour.isMultiple(of: 6) else { return "" }
        return hour < 12 ? "AM" : "PM"
    }
}

extension CGPoint {
    init(_ size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
}

struct Dial_Previews: PreviewProvider {
    static let scheme = ColorScheme.dark
    static var previews: some View {
        Group {
            VStack {
                Card {
                    Dial(rotation: .constant(Angle(degrees: 75)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("backgroundCard"))
                }
                .foregroundColor(Color("backgroundCard"))
                .padding()
            }
            .preferredColorScheme(scheme)

            Image("example")
                .resizable()
                .scaledToFit()
                .preferredColorScheme(scheme)
        }

    }
}

extension CGPoint {
    func angle(to comparisonPoint: CGPoint) -> Angle {
        let dX = comparisonPoint.x - x
        let dY = comparisonPoint.y - y
        let bearingRadians = atan2(Double(dY), Double(dX))
        return Angle(radians: bearingRadians)
    }
}
