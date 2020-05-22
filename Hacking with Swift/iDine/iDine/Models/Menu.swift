//
//  Menu.swift
//  iDine
//
//  Created by Djuro Alfirevic on 5/19/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct MenuSection: Codable, Identifiable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let items: [MenuItem]
    
}

struct MenuItem: Codable, Equatable, Identifiable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let photoCredit: String
    let price: Int
    let restrictions: [String]
    let description: String

    // MARK: - Computed Properties
    var mainImage: String {
        name.replacingOccurrences(of: " ", with: "-").lowercased()
    }

    var thumbnailImage: String {
        "\(mainImage)-thumb"
    }

    #if DEBUG
    static let example = MenuItem(id: UUID(), name: "Maple French Toast", photoCredit: "Joseph Gonzalez", price: 6, restrictions: ["G", "V"], description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
    #endif
    
}
