//
//  Restaurant.swift
//  SwiftUIActionSheet
//
//  Created by Djuro Alfirevic on 4/27/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let image: String
    var isFavorite = false
    var isCheckIn = false
}
