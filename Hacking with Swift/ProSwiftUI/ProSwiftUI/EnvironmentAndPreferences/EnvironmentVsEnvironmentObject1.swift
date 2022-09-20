//
//  EnvironmentVsEnvironmentObject1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct TitleFontKey: EnvironmentKey {
    static var defaultValue = Font.custom("Georgia", size: 34)
}

extension EnvironmentValues {
    var titleFont: Font {
        get { self[TitleFontKey.self] }
        set { self[TitleFontKey.self] = newValue }
    }
}

extension View {
    func titleFont(_ font: Font) -> some View {
        environment(\.titleFont, font)
    }
}

extension EnvironmentVsEnvironmentObject1 {
    struct CirclesView: View {
        @Environment(\.strokeWidth) var strokeWidth
        
        var body: some View {
            print("In CirclesView.body")

            return ForEach(0..<3) { _ in
                Circle()
                    .stroke(.red, lineWidth: strokeWidth)
            }
        }
    }
}

struct EnvironmentVsEnvironmentObject1: SelfCreatingView {
    @State private var sliderValue = 1.0
    @State private var titleFont = Font.largeTitle

    var body: some View {
        VStack {
            CirclesView()
            Text("Hello, world!")
                .font(titleFont)

            Slider(value: $sliderValue, in: 1...10)

            Button("Default Font") {
                titleFont = .largeTitle
            }

            Button("Custom Font") {
                titleFont = TitleFontKey.defaultValue
            }
        }
        .environment(\.strokeWidth, sliderValue)
        .environment(\.titleFont, titleFont)
    }
}


struct EnvironmentVsEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentVsEnvironmentObject1()
    }
}
