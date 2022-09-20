//
//  AvoidingPainIniOS56AndBelow.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension View {
    func animatableForegroundColor(_ color: Color) -> some View {
        self
            .foregroundColor(.white)
            .colorMultiply(color)
    }
}

struct AvoidingPainIniOS156AndBelow: SelfCreatingView {
    @State private var isRed = false

    var body: some View {
        Text("Hello, World!")
        Text("Hello, World!")
            .animatableForegroundColor(isRed ? .red : .blue)
            .font(.largeTitle.bold())
            .onTapGesture {
                withAnimation {
                    isRed.toggle()
                }
            }
    }
}


struct AvoidingPainIniOS156AndBelow_Previews: PreviewProvider {
    static var previews: some View {
        AvoidingPainIniOS156AndBelow()
    }
}
