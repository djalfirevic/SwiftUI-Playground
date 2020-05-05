//
//  BottomSheet.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .inactive, .pressing:
            return false
        }
    }
    
}

struct BottomSheet<Content>: View where Content: View {
    @Binding var isShow: Bool
    
    @GestureState private var dragState = DragState.inactive
    
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HandleBar()
                
                ScrollView(.vertical) {
                    self.content()
                }
                .animation(nil)
                .background(Color.white)
                .cornerRadius(10, antialiased: true)
                .disabled(self.dragState.isDragging)
            }
            .offset(y: geometry.size.height/3 + self.dragState.translation.height)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            .gesture(DragGesture()
                .updating(self.$dragState, body: { (value, state, transaction) in
                    if value.translation.height > 0 {
                        state = .dragging(translation: value.translation)
                    }

                })
                .onEnded({ (value) in
                
                    if value.translation.height > geometry.size.height * 0.5 {
                        self.isShow = false
                    }
                  
                })
            )
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(isShow: .constant(true)) {
            Text("Payment Details")
        }
    }
}

struct HandleBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}
