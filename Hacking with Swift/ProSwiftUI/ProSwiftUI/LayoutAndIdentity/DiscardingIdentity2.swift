//
//  DiscardingIdentity2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct DiscardingIdentity2: SelfCreatingView {
    @State private var items = Array(1...20)
    
    var body: some View {
        VStack(spacing: 0) {
            List(items, id: \.self) {
                Text("Item \($0)")
            }
            .id(UUID())
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            
            Button("Shuffle") {
                withAnimation(.easeInOut(duration: 1)) {
                    items.shuffle()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(5)
        }
    }
}

struct DiscardingIdentity2_Previews: PreviewProvider {
    static var previews: some View {
        DiscardingIdentity2()
    }
}
