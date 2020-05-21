//
//  Restaurant.swift
//  SwiftUIForm
//
//  Created by Djuro Alfirevic on 4/23/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var phone: String
    var image: String
    var priceLevel: Int
    var isFavorite: Bool = false
    var isCheckIn: Bool = false
}
