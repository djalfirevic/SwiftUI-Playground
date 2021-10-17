//
//  GradientIcon.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/3/21.
//

import SwiftUI

struct GradientIcon: View {
    var iconName: String
    var body: some View {
        LinearGradient(
            gradient: .init(colors: [
                Color("pink-gradient-1"),
                Color("pink-gradient-2"),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .mask(
            Image(systemName: iconName)
                .foregroundColor(.white)
                .font(.system(size: 17, weight: .semibold))
        )
    }
}

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        GradientIcon(iconName: "textformat.alt")
    }
}
