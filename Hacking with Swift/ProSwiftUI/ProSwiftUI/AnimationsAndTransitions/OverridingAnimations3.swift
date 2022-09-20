//
//  OverridingAnimations3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension OverridingAnimations3 {
    func withoutAnimation<Result>(_ body: () throws -> Result) rethrows -> Result {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        return try withTransaction(transaction, body)
    }
}
    
struct OverridingAnimations3: SelfCreatingView {
    @State var scale = 1.0
    
    var body: some View {
        Button("Tap Me") {
            withoutAnimation {
                scale += 1
            }
        }
        .scaleEffect(scale)
        .animation(.default, value: scale)
    }
}

struct OverridingAnimations3_Previews: PreviewProvider {
    static var previews: some View {
        OverridingAnimations3()
    }
}
