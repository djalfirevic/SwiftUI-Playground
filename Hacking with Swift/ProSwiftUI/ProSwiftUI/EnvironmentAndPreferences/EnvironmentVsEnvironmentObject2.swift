//
//  EnvironmentVsEnvironmentObject2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension EnvironmentVsEnvironmentObject2 {
    class ThemeManager: ObservableObject {
        @Published var strokeWidth = 1.0
        @Published var titleFont = TitleFontKey.defaultValue
    }
    
    struct CirclesView: View {
        @EnvironmentObject var theme: ThemeManager
    
        var body: some View {
            print("In CirclesView.body")
            
            return ForEach(0..<3) { _ in
                Circle()
                    .stroke(.red, lineWidth: theme.strokeWidth)
            }
        }
    }
}

struct EnvironmentVsEnvironmentObject2: SelfCreatingView {
    @StateObject private var theme = ThemeManager()

    var body: some View {
        VStack {
            CirclesView()
            Text("Hello, world!")
                .font(theme.titleFont)

            Slider(value: $theme.strokeWidth, in: 1...10)

            Button("Default Font") {
                theme.titleFont = .largeTitle
            }

            Button("Custom Font") {
                theme.titleFont = TitleFontKey.defaultValue
            }
        }
        .environmentObject(theme)
    }

}

struct EnvironmentVsEnvironmentObject2_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentVsEnvironmentObject2()
    }
}
