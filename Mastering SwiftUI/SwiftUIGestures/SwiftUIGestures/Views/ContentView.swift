//
//  ContentView.swift
//  SwiftUIGestures
//
//  Created by Djuro Alfirevic on 4/28/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @GestureState private var dragState = DragState.inactive
    @State private var position = CGSize.zero
    
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 100))
            .opacity(dragState.isPressing ? 0.5 : 1.0)
            .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
            .animation(.easeInOut)
            .foregroundColor(.green)
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                .sequenced(before: DragGesture())
                .updating($dragState, body: { (value, state, transaction) in
                    switch value {
                    case .first(true):
                        state = .pressing
                    case .second(true, let drag):
                        state = .dragging(translation: drag?.translation ?? .zero)
                    default:
                        break
                    }
                })
                .onEnded({ (value) in
                    guard case .second(true, let drag?) = value else { return }

                    self.position.height += drag.translation.height
                    self.position.width += drag.translation.width
                })
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
