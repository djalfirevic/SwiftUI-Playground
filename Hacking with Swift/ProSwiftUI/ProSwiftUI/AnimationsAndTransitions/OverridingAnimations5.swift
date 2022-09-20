//
//  OverridingAnimations5.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension OverridingAnimations5 {
    struct CircleGrid: View {
        var useRedFill = false
        
        var body: some View {
            LazyVGrid(columns: [.init(.adaptive(minimum: 64))]) {
                ForEach(0..<30) { i in
                    Circle()
                        .fill(useRedFill ? .red : .blue)
                        .frame(height: 64)
                        .transaction { transaction in
                            transaction.animation = transaction.animation?.delay(Double(i) / 10)
                        }
                }
            }
        }
    }
}


struct OverridingAnimations5: SelfCreatingView {
    @State var useRedFill = false

    var body: some View {
        VStack {
            CircleGrid(useRedFill: useRedFill)

            Spacer()

            Button("Toggle Color") {
                withAnimation(.easeInOut) {
                    useRedFill.toggle()
                }
            }
        }
    }
}

struct OverridingAnimations5_Previews: PreviewProvider {
    static var previews: some View {
        OverridingAnimations5()
    }
}
