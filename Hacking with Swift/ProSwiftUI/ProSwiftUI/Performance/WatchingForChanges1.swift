//
//  WatchingForChanges1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension WatchingForChanges1 {
    class AutorefreshingObject: ObservableObject {
        var timer: Timer?
        
        init() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.objectWillChange.send()
            }
        }
    }
}

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

struct WatchingForChanges1: SelfCreatingView {
    @StateObject private var viewModel = AutorefreshingObject()

    var body: some View {
        Text("Example View Here")
            .background(.random)
    }
}

struct WatchingForChanges1_Previews: PreviewProvider {
    static var previews: some View {
        WatchingForChanges1()
    }
}
