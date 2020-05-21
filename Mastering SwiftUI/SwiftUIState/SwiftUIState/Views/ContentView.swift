//
//  ContentView.swift
//  SwiftUIState
//
//  Created by Djuro Alfirevic on 4/14/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isPlaying = false
    @State private var counter = 0
    @State private var counterBlue = 0
    @State private var counterGreen = 0
    @State private var counterRed = 0
    
    var body: some View {
        VStack {
            Button(action: {
                self.isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.system(size: 150))
                    .foregroundColor( isPlaying ? .red : .green)
            }
            .padding(.bottom, 20)
            VStack {
                CounterButton(counter: $counter, color: .blue)
                CounterButton(counter: $counter, color: .green)
                CounterButton(counter: $counter, color: .red)
            }
            VStack {
                Text("\(counterBlue + counterGreen + counterRed)")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                HStack {
                    CounterButton(counter: $counterBlue, color: .blue)
                    CounterButton(counter: $counterGreen, color: .green)
                    CounterButton(counter: $counterRed, color: .red)
                }
            }
            .padding(.top, 20)
        }
    }
}

struct CounterButton: View {
    @Binding var counter: Int
    var color: Color
    
    var body: some View {
        Button(action: {
            self.counter += 1
        }) {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(color)
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
