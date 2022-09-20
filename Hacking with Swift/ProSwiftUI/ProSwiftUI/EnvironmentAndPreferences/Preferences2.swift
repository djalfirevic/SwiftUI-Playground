//
//  Preferences2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct Preferences2: SelfCreatingView {
    @State private var width = 0.0

    var body: some View {
        VStack {
            SizingView()

            Text("100%")
                .frame(width: width)
                .background(.red)

            Text("150%")
                .frame(width: width * 1.5)
                .background(.green)

            Text("200%")
                .frame(width: width * 2)
                .background(.blue)
        }
        .onPreferenceChange(WidthPreferenceKey.self) { width = $0 }
        .navigationTitle("Width: \(width)")
    }
}

struct Preferences2_Previews: PreviewProvider {
    static var previews: some View {
        Preferences2()
    }
}
