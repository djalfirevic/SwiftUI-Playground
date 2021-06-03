//
//  FAQ.swift
//  SwiftUICombineData
//
//  Created by Stephanie Diep on 2021-05-18.
//

import Foundation

struct FAQ: Decodable, Identifiable {
    var id: Int
    var question: String
    var answer: String
}
