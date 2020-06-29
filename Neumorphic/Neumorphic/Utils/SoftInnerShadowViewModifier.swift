//
//  SoftInnerShadowModifier.swift
//  Neumorphic
//
//  Created by Djuro Alfirevic on 6/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

private struct SoftInnerShadowViewModifier<S: Shape> : ViewModifier {
    
    // MARK: - Properties
    var shape: S
    var darkShadowColor: Color = .black
    var lightShadowColor: Color = .white
    var spread: CGFloat = 0.5
    var radius: CGFloat = 10
    
    // MARK: - Initializer
    init(shape: S, darkShadowColor: Color, lightShadowColor: Color, spread: CGFloat, radius:CGFloat) {
        self.shape = shape
        self.darkShadowColor = darkShadowColor
        self.lightShadowColor = lightShadowColor
        self.spread = spread
        self.radius = radius
    }

    // MARK: - Private API
    fileprivate func strokeLineWidth(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 0.10
    }
    
    fileprivate func strokeLineScale(_ geo: GeometryProxy) -> CGFloat {
        let lineWidth = strokeLineWidth(geo)
        return geo.size.width / CGFloat(geo.size.width - lineWidth)
    }
    
    fileprivate func shadowOffset(_ geo: GeometryProxy) -> CGFloat {
        return geo.size.width * 0.5 * min(max(spread, 0), 1)
    }
    
    fileprivate func addSoftInnerShadow(_ content: SoftInnerShadowViewModifier.Content) -> some View {
        return GeometryReader { geo in
            self.shape.fill(self.lightShadowColor)
                .inverseMask(
                    self.shape
                    .offset(x: -self.shadowOffset(geo), y: -self.shadowOffset(geo))
                )
                .offset(x: self.shadowOffset(geo) , y: self.shadowOffset(geo))
                .blur(radius: self.radius)
                .shadow(color: self.lightShadowColor, radius: self.radius, x: -self.shadowOffset(geo)/2, y: -self.shadowOffset(geo)/2 )
                .mask(self.shape)
                .overlay(
                    self.shape
                        .fill(self.darkShadowColor)
                        .inverseMask(
                            self.shape
                            .offset(x: self.shadowOffset(geo), y: self.shadowOffset(geo))
                        )
                        .offset(x: -self.shadowOffset(geo) , y: -self.shadowOffset(geo))
                        .blur(radius: self.radius)
                        .shadow(color: self.darkShadowColor, radius: self.radius, x: self.shadowOffset(geo)/2, y: self.shadowOffset(geo)/2 )
                )
                .mask(
                    self.shape
                )
        }
    }

    // MARK: - Public API
    func body(content: Content) -> some View {
        content.overlay(
            addSoftInnerShadow(content)
        )
    }
    
}

extension View {
    public func softInnerShadow<S : Shape>(_ content: S, darkShadow: Color = Neumorphic.shared.darkShadowColor(), lightShadow: Color = Neumorphic.shared.lightShadowColor(), spread: CGFloat = 0.5, radius: CGFloat = 10) -> some View {
        modifier(
            SoftInnerShadowViewModifier(shape: content, darkShadowColor: darkShadow, lightShadowColor: lightShadow, spread: spread, radius: radius)
        )
    }
}
