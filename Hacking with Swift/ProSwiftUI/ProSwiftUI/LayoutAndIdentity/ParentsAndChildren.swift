//
//  ParentsAndChildren.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension ParentsAndChildren {
    struct CustomFont: ViewModifier {
        func body(content: Content) -> some View {
            content.font(.largeTitle)
        }
    }
}

struct ParentsAndChildren: SelfCreatingView {
    var body: some View {
        ModifiedContent(content: Text("Hello"), modifier: CustomFont())
            .onTapGesture {
                print(type(of: self.body))
            }
    }
}

struct ParentsAndChildren_Previews: PreviewProvider {
    static var previews: some View {
        ParentsAndChildren()
    }
}
