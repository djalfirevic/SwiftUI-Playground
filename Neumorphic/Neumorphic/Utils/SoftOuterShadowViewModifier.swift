//
//  SoftOuterShadow.swift
//  Neumorphic
//
//  Created by Djuro Alfirevic on 6/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

private struct SoftOuterShadowViewModifier: ViewModifier {
    
    // MARK: - Properties
    var lightShadowColor: Color
    var darkShadowColor: Color
    var offset: CGFloat
    var radius: CGFloat
    
    // MARK: - Initializer
    init(darkShadowColor: Color, lightShadowColor: Color, offset: CGFloat, radius: CGFloat) {
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.offset = offset
        self.radius = radius
    }

    // MARK: - Public API
    func body(content: Content) -> some View {
        content
        .shadow(color: darkShadowColor, radius: radius, x: offset, y: offset)
        .shadow(color: lightShadowColor, radius: radius, x: -offset, y: -offset)
    }

}

extension View {
    public func softOuterShadow(darkShadow: Color = Neumorphic.shared.darkShadowColor(), lightShadow: Color = Neumorphic.shared.lightShadowColor(), offset: CGFloat = 6, radius:CGFloat = 3) -> some View {
        modifier(SoftOuterShadowViewModifier(darkShadowColor: darkShadow, lightShadowColor: lightShadow, offset: offset, radius: radius))
    }
}
