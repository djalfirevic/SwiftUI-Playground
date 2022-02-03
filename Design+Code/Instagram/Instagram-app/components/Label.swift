//
//  Label.swift
//  Instagram-app
//
//  Created by Willie Yam on 2022-01-13.
//

import SwiftUI

struct Label: View {
    var text: String = "Design"
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.secondary, lineWidth: 1)
            )
    }
}

struct Label_Previews: PreviewProvider {
    static var previews: some View {
        Label()
    }
}
