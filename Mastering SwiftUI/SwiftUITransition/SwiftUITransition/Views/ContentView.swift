//
//  ContentView.swift
//  SwiftUITransition
//
//  Created by Djuro Alfirevic on 4/17/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var show = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay(
                    Text("Show details")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.white)

            )

            if show {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay(
                        Text("Well, here is the details")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                    )
                    //.transition(.scale(scale: 0, anchor: .bottom))
                    //.transition(.offset(x: -600, y: 0))
                    //.transition(AnyTransition.offset(x: -600, y: 0).combined(with: .scale))
                    //.transition(.offsetScaleOpacity)
                    .transition(.scaleAndOffset)
            }
            
            FancyButton()
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.show.toggle()
            }
        }
    }
}

struct FancyButton: View {
    @State private var processing = false
    @State private var completed = false
    @State private var loading = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: processing ? 250 : 200, height: 60)
                .foregroundColor(completed ? .red : .green)
            
            if !processing {
                Text("Submit")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .transition(.move(edge: .top))
            }
            
            if processing && !completed {
                HStack {
                    Circle()
                        .trim(from: 0, to: 0.9)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .rotationEffect(Angle(degrees: loading ? 360 : 0))
                        .animation(Animation.easeOut.repeatForever(autoreverses: false))
                    
                    Text("Processing")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                }
                .transition(.opacity)
                .onAppear() {
                    self.startProcessing()
                }

            }
              
            if completed {
                Text("Done")
                .font(.system(.title, design: .rounded))
                .bold()
                .foregroundColor(.white)
                .onAppear() {
                    self.endProcessing()
                }
            }
        }
        .animation(.spring())
        .onTapGesture {
            self.processing.toggle()

        }
    }
    
    private func startProcessing() {
        self.loading = true
        
        // Simulate an operation by using DispatchQueue.main.asyncAfter
        // In a real world project, you will perform a task here.
        // When the task finishes, you set the completed status to true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.completed = true
        }
    }
    
    private func endProcessing() {
        // Reset the button's state
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.processing = false
            self.completed = false
            self.loading = false
        }
    }
}


extension AnyTransition {
    static var offsetScaleOpacity: AnyTransition {
        AnyTransition.offset(x: -600, y: 0).combined(with: .scale).combined(with: .opacity)
    }
    
    static var scaleAndOffset: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .scale(scale: 0, anchor: .bottom),
            removal: .offset(x: -600, y: 00)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
