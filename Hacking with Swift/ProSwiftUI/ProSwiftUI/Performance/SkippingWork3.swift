//
//  SkippingWork3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

public extension View {
    func watchOS<Content: View>(_ modifier: @escaping (Self) -> Content) -> some View {
        #if os(watchOS)
        modifier(self)
        #else
        self
        #endif
    }
}

struct SkippingWork3: SelfCreatingView {
    var body: some View {
        Text("Hello, world!")
            .watchOS {
                $0.padding(0)
            }
    }
}

struct SkippingWork3_Previews: PreviewProvider {
    static var previews: some View {
        SkippingWork3()
    }
}
