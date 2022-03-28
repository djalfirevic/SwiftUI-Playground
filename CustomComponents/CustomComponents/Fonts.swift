//
//  Fonts.swift
//  CustomComponents
//
//  Created by Djuro on 3/28/22.
//

import SwiftUI
import UIKit

enum FontFamily: String, CaseIterable {
    case pangram = "Pangram"
}

enum FontStyle: String, CaseIterable {
    case regular = "Regular"
    case light = "Light"
    case extraLight = "ExtraLight"
    case medium = "Medium"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case black = "Black"
}

enum FontSize: CGFloat, CaseIterable {
    case headline = 50
    case title = 40
    case h1 = 36
    case h2 = 28
    case h3 = 24
    case h4 = 20
    case h5 = 18
    case body = 16
    case caption = 14
    case p1 = 13
    case error = 12
    case small = 10
}

extension Font {
    static func custom(family: FontFamily = .pangram, style: FontStyle = .regular, ofSize size: FontSize) -> Font {
        let name = String(format: "%@-%@", family.rawValue, style.rawValue)
        return Font.custom(name, size: size.rawValue)
    }
}

extension UIFont {
    static func custom(family: FontFamily = .pangram, style: FontStyle = .regular, ofSize size: FontSize) -> UIFont {
        let name = String(format: "%@-%@", family.rawValue, style.rawValue)
        return UIFont(name: name, size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
    }
}
