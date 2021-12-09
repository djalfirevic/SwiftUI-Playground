//
//  CardView.swift
//  PaperCSS
//
//  Created by Djuro on 12/8/21.
//

import SwiftUI

enum ShapeType: String {
    case shape1 = "shape-1"
    case shape2 = "shape-2"
    case shape3 = "shape-3"
}

struct Card<Content: View>: View {
    let shape: ShapeType
    @State private var hovered = false
    var content: () -> Content
    
    var body: some View {
        content()
            .padding()
            .background(
                Image(shape.rawValue)
                    .resizable()
            )
            .scaleEffect(hovered ? 2.0 : 1.0)
            .shadow(color: Color.black.opacity(0.2),
                    radius: 4,
                    x: hovered ? 1 : 5,
                    y: hovered ? 1 : 5)
            .animation(.default, value: hovered)
            .onHover { isHovered in
                self.hovered = isHovered
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Card(shape: .shape1) {
                Text("Documentation")
                    .font(Font.custom("ChalkboardSE-Light", fixedSize: 16))
            }
        }
    }
}
