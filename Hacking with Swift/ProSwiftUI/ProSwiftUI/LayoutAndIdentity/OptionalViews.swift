//
//  OptionalViews.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct OptionalViews: SelfCreatingView {
    var body: some View {
        Text("Hello")
            .background(Bool.random() ? Color.blue : nil)
            .onTapGesture {
                print(type(of: self.body))
            }
    }
}

struct OptionalViews_Previews: PreviewProvider {
    static var previews: some View {
        OptionalViews()
    }
}
