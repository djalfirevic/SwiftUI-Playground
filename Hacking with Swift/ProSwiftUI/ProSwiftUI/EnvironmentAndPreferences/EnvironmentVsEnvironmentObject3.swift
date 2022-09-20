//
//  EnvironmentVsEnvironmentObject3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

protocol Theme {
    var strokeWidth: Double { get set }
    var titleFont: Font { get set }
}


extension EnvironmentValues {
    var theme: any Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

struct ThemeKey: EnvironmentKey {
    static var defaultValue: any Theme = ThemeManager.shared.activeTheme
}

struct DefaultTheme: Theme {
    var strokeWidth = 1.0
    var titleFont = TitleFontKey.defaultValue
}

class ThemeManager: ObservableObject {
    @Published var activeTheme: any Theme = DefaultTheme()

    static var shared = ThemeManager()
    private init() { }
}

extension EnvironmentVsEnvironmentObject3 {
    struct CirclesView: View {
        @Environment(\.theme.strokeWidth) var strokeWidth
        
        var body: some View {
            print("In CirclesView.body")
            
            return ForEach(0..<3) { _ in
                Circle()
                    .stroke(.red, lineWidth: strokeWidth)
            }
        }
    }
}

struct ThemeModifier: ViewModifier {
    @ObservedObject var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        content.environment(\.theme, themeManager.activeTheme)
    }
}

extension View where Self == EnvironmentVsEnvironmentObject3 {
    func themed() -> some View {
        modifier(ThemeModifier())
    }
}

struct EnvironmentVsEnvironmentObject3: SelfCreatingView {
    @ObservedObject var theme = ThemeManager.shared

    var body: some View {
        VStack {
            CirclesView()
            Text("Hello, world!")
                .font(theme.activeTheme.titleFont)

            Slider(value: $theme.activeTheme.strokeWidth, in: 1...10)

            Button("Default Font") {
                theme.activeTheme.titleFont = .largeTitle
            }

            Button("Custom Font") {
                theme.activeTheme.titleFont = TitleFontKey.defaultValue
            }
        }
        .environmentObject(theme)
    }

}

struct EnvironmentVsEnvironmentObject3_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentVsEnvironmentObject3()
    }
}
