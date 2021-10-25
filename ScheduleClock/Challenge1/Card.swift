//
//  Card.swift
//  Card
//
//  Created by Quinn McHenry on 8/26/21.
//

import SwiftUI

struct Card<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity)
        .background(Color("backgroundCard"))
        .cornerRadius(9)
    }
}

struct Card_Previews: PreviewProvider {
    static let scheme = ColorScheme.dark
    static var previews: some View {
        Card {
            Text("hi")
                .preferredColorScheme(scheme)
        }
    }
}
