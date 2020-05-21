//
//  Card.swift
//  Pairs
//
//  Created by Djuro Alfirevic on 4/17/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

enum CardState {
    case unflipped, flipped, matched
}

struct Card: Codable {
    let id = UUID()
    let a: String
    let b: String
}

struct CardPart {
    let id: UUID
    let text: String
    var state = CardState.unflipped
}
