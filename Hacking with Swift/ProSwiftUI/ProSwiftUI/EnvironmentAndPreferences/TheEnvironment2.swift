//
//  TheEnvironment2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct StrokeWidthKey: EnvironmentKey {
    static var defaultValue = 1.0
}

extension EnvironmentValues {
    var strokeWidth: Double {
        get { self[StrokeWidthKey.self] }
        set { self[StrokeWidthKey.self] = newValue }
    }
}

extension View {
    func strokeWidth(_ width: Double) -> some View {
        environment(\.strokeWidth, width)
    }
}

extension TheEnvironment2 {
    struct CirclesView: View {
        @Environment(\.strokeWidth) var strokeWidth
        
        var body: some View {
            ForEach(0..<3) { _ in
                Circle()
                    .stroke(.red, lineWidth: strokeWidth)
            }
        }
    }
}

struct TheEnvironment2: SelfCreatingView {
    @State private var sliderValue = 1.0

    var body: some View {
        VStack {
            CirclesView()
            Slider(value: $sliderValue, in: 1...10)
        }
        .strokeWidth(sliderValue)
    }
}

struct TheEnvironment2_Previews: PreviewProvider {
    static var previews: some View {
        TheEnvironment2()
    }
}
