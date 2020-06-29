//
//  Neumorphic.swift
//  Neumorphic
//
//  Created by Djuro Alfirevic on 6/29/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

public struct Neumorphic {
    
    // MARK: - Properties
    public static let defaultMainColor = Color(rgb: 0xecf0f3, alpha: 1)
    public static let defaultSecondaryColor = Color(rgb: 0x7b808c, alpha: 1)
    public static let defaultLightShadowColor = Color(rgb:0xffffff, alpha: 1)
    public static let defaultDarkShadowColor = Color(rgb: 0xd1d9e6, alpha: 1)

    public static let darkThemeMainColor = Color(rgb: 0x303135, alpha: 1)
    public static let darkThemeSecondaryColor = Color(rgb: 0xe8e8e8, alpha: 1)
    public static let darkThemeLightShadowColor = Color(rgb:0x3e3f46, alpha: 1)
    public static let darkThemeDarkShadowColor = Color(rgb: 0x232323, alpha: 1)
        
    public static var shared = Neumorphic()
    
    public var colorScheme : ColorScheme = .light
    
    // MARK: - Public API
    public func mainColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultMainColor : Neumorphic.darkThemeMainColor
    }
    
    public func secondaryColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultSecondaryColor : Neumorphic.darkThemeSecondaryColor
    }
    
    public func lightShadowColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultLightShadowColor : Neumorphic.darkThemeLightShadowColor
    }
    
    public func darkShadowColor() -> Color {
        colorScheme == .light ? Neumorphic.defaultDarkShadowColor : Neumorphic.darkThemeDarkShadowColor
    }
    
}
