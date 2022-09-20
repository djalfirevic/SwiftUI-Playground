//
//  FixingViewSizes1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 05/09/2022.
//

import SwiftUI

struct FixingViewSizes1: SelfCreatingView {
    var body: some View {
        VStack(alignment: .leading) {
            Image("wide-image")
                .frame(minWidth: 0, maxWidth: .infinity)
            Text("Hello, World! This is a layout test.")
        }
    }
}

struct FixingViewSizes1_Previews: PreviewProvider {
    static var previews: some View {
        FixingViewSizes1()
    }
}
