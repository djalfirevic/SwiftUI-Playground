//
//  ContentView.swift
//  Pairs
//
//  Created by Djuro Alfirevic on 4/17/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var cardPart: CardPart
    
    var body: some View {
        ZStack {
            CardBack()
                .rotation3DEffect(.degrees(cardPart.state == .unflipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
                .opacity(cardPart.state == .unflipped ? 1 : 0)
            CardFront(cardPart: cardPart)
                .rotation3DEffect(.degrees(cardPart.state != .unflipped ? 0 : -180), axis: (x: 0, y: 1, z: 0))
                .opacity(cardPart.state != .unflipped ? 1 : -1)
        }
    }
}

struct CardBack: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.blue)
            .frame(width: 140, height: 100)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

struct CardFront: View {
    var cardPart: CardPart
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(cardPart.state == .matched ? Color.green : Color.white)
                .frame(width: 140, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(Color.white, lineWidth: 2)
                )
            
            Text(cardPart.text)
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

struct ContentView: View {
    @ObservedObject var deck = Deck()
    
    @State private var state = GameState.start
    @State private var firstIndex: Int?
    @State private var secondIndex: Int?
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let rowCount = 4
    let columnCount = 6
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.init(white: 0.3), .black]), startPoint: .top, endPoint: .bottom)
            
            VStack {
                Image(decorative: "pairs")
                
                GridStack(rows: rowCount, columns: columnCount, content: card)
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
            }
            .padding()
        }
        .onReceive(timer, perform: updateTimer(_:))
    }
    
    func card(atRow row: Int, column: Int) -> some View {
        let index = (row * columnCount) + column
        let part = deck.cardParts[index]
        
        return CardView(cardPart: part)
            .accessibility(addTraits: .isButton)
            .accessibility(label: Text(part.text))
            .onTapGesture {
                self.flip(index)
            }
    }
    
    func flip(_ index: Int) {
        guard deck.cardParts[index].state == .unflipped else { return }
        guard secondIndex == nil else { return }
        
        switch state {
        case .start:
            withAnimation {
                self.firstIndex = index
                self.deck.set(index, to: .flipped)
                self.state = .firstFlipped
            }
        case .firstFlipped:
            withAnimation {
                self.secondIndex = index
                self.deck.set(index, to: .flipped)
                self.checkMatches()
            }
        }
    }
    
    func match() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be two flip cards before matching.")
        }
        
        withAnimation {
            deck.set(first, to: .matched)
            deck.set(second, to: .matched)
        }
        
        reset()
    }
    
    func noMatch() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be two flip cards before matching.")
        }
        
        withAnimation {
            deck.set(first, to: .unflipped)
            deck.set(second, to: .unflipped)
        }
        
        reset()
    }
    
    func reset() {
        firstIndex = nil
        secondIndex = nil
        state = .start
    }
    
    func checkMatches() {
        guard let first = firstIndex, let second = secondIndex else {
            fatalError("There must be two flip cards before matching.")
        }
        
        if deck.cardParts[first].id == deck.cardParts[second].id {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: match)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: noMatch)
        }
    }
    
    func updateTimer(_ currentTime: Date) {
        let unmatched = deck.cardParts.filter { $0.state != .matched }
        guard !unmatched.isEmpty else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
