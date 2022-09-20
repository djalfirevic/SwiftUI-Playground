//
//  MultipleFrames1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct MultipleFrames1: SelfCreatingView {
    var body: some View {
        Text("Hello, World!")
            .frame(width: 200, height: 200)
            .background(.blue)
            .frame(width: 300, height: 300)
            .background(.red)
            .foregroundColor(.white)
    }
}

struct MultipleFrames1_Previews: PreviewProvider {
    static var previews: some View {
        MultipleFrames1()
    }
}
