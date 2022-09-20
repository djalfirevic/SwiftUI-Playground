//
//  UnderstandingIdentity1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct UnderstandingIdentity1: SelfCreatingView {
    var body: some View {
        VStack {
            if Bool.random() {
                Text("Hello")
            } else {
                Text("Goodbye")
            }
        }
        .onTapGesture {
            print(type(of: self.body))
        }
    }
}

struct UnderstandingIdentity1_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingIdentity1()
    }
}
