//
//  DiscardingIdentity1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct DiscardingIdentity1: SelfCreatingView {
    @State private var items = Array(1...20)
    
    var body: some View {
        VStack(spacing: 0) {
            List(items, id: \.self) {
                Text("Item \($0)")
            }
            
            Button("Shuffle") {
                withAnimation {
                    items.shuffle()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(5)
        }
    }
}

struct DiscardingIdentity1_Previews: PreviewProvider {
    static var previews: some View {
        DiscardingIdentity1()
    }
}
