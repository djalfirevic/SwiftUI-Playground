//
//  GradientText.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/1/21.
//

import SwiftUI

struct GradientText: View {
    var text: String = "Text here"

    var body: some View {
        Text(text)
            .gradientForeground(colors: [Color(#colorLiteral(red: 0.6196078431, green: 0.6784313725, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5607843137, blue: 0.9803921569, alpha: 1))])

    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}


struct GradientText_Previews: PreviewProvider {
    static var previews: some View {
        GradientText()
    }
}
