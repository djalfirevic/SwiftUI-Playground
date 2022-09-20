//
//  MultipleFrames2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct MultipleFrames2: SelfCreatingView {
    var body: some View {
        Text("Hello, World!")
            .background(.blue)
            .frame(width: 250)
            .background(.red)
            .frame(minWidth: 400)
            .background(.yellow)
    }
}

struct MultipleFrames2_Previews: PreviewProvider {
    static var previews: some View {
        MultipleFrames2()
    }
}
