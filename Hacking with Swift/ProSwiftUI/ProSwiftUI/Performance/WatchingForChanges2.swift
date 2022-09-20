//
//  WatchingForChanges2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension WatchingForChanges2 {
    class AutorefreshingObject: ObservableObject {
        var timer: Timer?
    
        init() {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                self.objectWillChange.send()
            }
        }
    }
}

struct WatchingForChanges2: SelfCreatingView {
    @StateObject private var viewModel = AutorefreshingObject()
    
    var body: some View {
        let _ = Self._printChanges()
        Text("Example View Here")
    }
}

struct WatchingForChanges2_Previews: PreviewProvider {
    static var previews: some View {
        WatchingForChanges2()
    }
}
