//
//  Preferences1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static let defaultValue = 0.0

    static func reduce(value: inout Double, nextValue: () -> Double) {
        value = nextValue()
    }
}

struct SizingView: View {
    @State private var width = 50.0

    var body: some View {
        Color.red
            .frame(width: width, height: 100)
            .onTapGesture {
                width = Double.random(in: 50...160)
            }
            .preference(key: WidthPreferenceKey.self, value: width)
    }
}

struct Preferences1: SelfCreatingView {
    @State private var width = 0.0

    var body: some View {
        VStack {
            SizingView()
        }
        .onPreferenceChange(WidthPreferenceKey.self) { width = $0 }
        .navigationTitle("Width: \(width)")
    }

}

struct Preferences1_Previews: PreviewProvider {
    static var previews: some View {
        Preferences1()
    }
}
