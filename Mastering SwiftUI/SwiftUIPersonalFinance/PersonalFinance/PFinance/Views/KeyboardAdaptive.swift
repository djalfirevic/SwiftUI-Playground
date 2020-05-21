//
//  KeyboardAdaptive.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI
import Combine

struct KeyboardAdaptive: ViewModifier {
    @State var currentHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight)
            .onAppear(perform: handleKeyboardEvents)
    }

    private func handleKeyboardEvents() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification
        ).compactMap { (notification) in
            notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
        }.map { rect in
            rect.height
        }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification
        ).compactMap { _ in
            CGFloat.zero
        }.subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

    }
}

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
