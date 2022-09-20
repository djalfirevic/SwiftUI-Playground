//
//  FixingViewSizes2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 05/09/2022.
//

import SwiftUI

struct FixingViewSizes2: SelfCreatingView {
    var body: some View {
        HStack {
            Text("Forecast")
                .padding()
                .frame(maxHeight: .infinity)
                .background(.yellow)
            Text("The rain in Spain falls mainly on the Spaniards")
                .padding()
                .frame(maxHeight: .infinity)
                .background(.cyan)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct FixingViewSizes2_Previews: PreviewProvider {
    static var previews: some View {
        FixingViewSizes2()
    }
}
