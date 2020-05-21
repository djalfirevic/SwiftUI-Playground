//
//  Deck.swift
//  Pairs
//
//  Created by Djuro Alfirevic on 4/17/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

enum GameState {
    case start, firstFlipped
}

class Deck: ObservableObject {
    let allCards: [Card] = Bundle.main.decode("math.json")
    var cardParts = [CardPart]()
    
    init() {
        let selectedCards = allCards.shuffled().prefix(12)
        
        for card in selectedCards {
            cardParts.append(CardPart(id: card.id, text: card.a))
            cardParts.append(CardPart(id: card.id, text: card.b))
        }
        
        cardParts.shuffle()
    }
    
    func set(_ index: Int, to state: CardState) {
        cardParts[index].state = state
        objectWillChange.send()
    }
}
