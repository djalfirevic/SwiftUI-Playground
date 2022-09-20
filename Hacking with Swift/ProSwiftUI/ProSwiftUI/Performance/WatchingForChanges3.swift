//
//  WatchingForChanges3.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension View {
    func debugPrint(_ value: @autoclosure () -> Any) -> some View {
        #if DEBUG
        print(value())
        #endif

        return self
    }

    func debugExecute(_ function: () -> Void) -> some View {
        #if DEBUG
        function()
        #endif

        return self
    }

    func debugExecute(_ function: (Self) -> Void) -> some View {
        #if DEBUG
        function(self)
        #endif

        return self
    }
    
    public func assert(
      _ condition: @autoclosure () -> Bool,
      _ message: @autoclosure () -> String = String(),
      file: StaticString = #file, line: UInt = #line
    ) -> some View {
        Swift.assert(condition(), message(), file: file, line: line)
        return self
    }
}


struct WatchingForChanges3: SelfCreatingView {
    @State private var counter = 0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("⚠️ Xcode will trigger a crash when the number below reaches 100")
                .multilineTextAlignment(.center)
            
            Text(String(counter))
                .font(.largeTitle)
        }
        .onReceive(timer) { _ in
            counter += 1
        }
        .assert(counter < 100, "Timer exceeded")
    }
}

struct WatchingForChanges3_Previews: PreviewProvider {
    static var previews: some View {
        WatchingForChanges3()
    }
}
