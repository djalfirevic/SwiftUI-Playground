//
//  DiscardingIdentity3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct DiscardingIdentity3: SelfCreatingView {
    let colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]
    let symbols = ["run", "archery", "basketball", "bowling", "dance", "golf", "hiking", "jumprope", "rugby", "tennis", "volleyball", "yoga"]
    @State private var id = UUID()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(colors.randomElement()!)
                    .padding()
                
                Image(systemName: "figure.\(symbols.randomElement()!)")
                    .font(.system(size: 144))
                    .foregroundColor(.white)
            }
            .transition(.slide)
            .id(id)
            
            Button("Change") {
                withAnimation(.easeInOut(duration: 1)) {
                    id = UUID()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
    }
}

struct DiscardingIdentity3_Previews: PreviewProvider {
    static var previews: some View {
        DiscardingIdentity3()
    }
}
