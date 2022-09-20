//
//  LayoutNeutrality.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct LayoutNeutrality: SelfCreatingView {
    @State private var usesFixedSize = false

    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: usesFixedSize ? 300 : nil)
                .background(.red)

            Toggle("Fixed sizes", isOn: $usesFixedSize.animation())
        }
    }
}

struct LayoutNeutrality_Previews: PreviewProvider {
    static var previews: some View {
        LayoutNeutrality()
    }
}
