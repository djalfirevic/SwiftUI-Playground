//
//  UnderstandingIdentity2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension UnderstandingIdentity2 {
    enum ViewState {
        case a, b, c, d, e, f
    }
}

struct UnderstandingIdentity2: SelfCreatingView {
    @State var loadState = ViewState.a

    @ViewBuilder var state: some View {
        switch loadState {
        case .a:
            Text("a")
        case .b:
            Image(systemName: "plus")
        case .c:
            Circle()
        case .d:
            Rectangle()
        case .e:
            Capsule()
        case .f:
            RoundedRectangle(cornerRadius: 25)
        }
    }

    var body: some View {
        Button("Press") {
            print(type(of: state))
        }
    }
}

struct UnderstandingIdentity2_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingIdentity2()
    }
}
