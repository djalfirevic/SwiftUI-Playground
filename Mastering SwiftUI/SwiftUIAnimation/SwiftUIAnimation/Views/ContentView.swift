//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by Djuro Alfirevic on 4/16/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var heartSizeChanged = false
    
    var body: some View {
        VStack {
            Hearts()
            LoadingIndicator()
            RectangularLoadingIndicator()
                .padding(.top, 50)
            ProgressIndicator()
            DotLoadingIndicator()
            Morph()
        }
    }
}

struct Hearts: View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)

                Image(systemName: "heart.fill")
                    .foregroundColor(heartColorChanged ? .red : .white)
                    .font(.system(size: 50))
                    .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
            }
            //.animation(.default)
            .onTapGesture {
                withAnimation(.default) {
                    self.circleColorChanged.toggle()
                    self.heartColorChanged.toggle()
                    self.heartSizeChanged.toggle()
                }
            }
            
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)

                Image(systemName: "heart.fill")
                    .foregroundColor(heartColorChanged ? .red : .white)
                    .font(.system(size: 50))
                    .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
            .onTapGesture {
                self.circleColorChanged.toggle()
                self.heartColorChanged.toggle()
                self.heartSizeChanged.toggle()
            }
        }
    }
}

struct LoadingIndicator: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}

struct ProgressIndicator: View {
    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded))
                .bold()

            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 150, height: 150)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                self.progress += 0.05
                print(self.progress)
                    
                if self.progress >= 1.0 {
                    timer.invalidate()
                }
            }
        }
    }
}

struct RectangularLoadingIndicator: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Text("Loading")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)

            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)

            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            }
            .onAppear() {
                self.isLoading = true
        }
    }
}

struct DotLoadingIndicator: View {
    @State private var isLoading = false

    var body: some View {
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(Animation.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)))
            }
        }
        .onAppear() {
            self.isLoading = true
        }
    }
}

struct Morph: View {
    @State private var recordBegin = false
    @State private var recording = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.system(.title))
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )

                RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                    .trim(from: 0, to: recordBegin ? 0 : 1)
                    .stroke(lineWidth: 5)
                    .frame(width: recordBegin ? 70 : 260, height: 70)
                    .foregroundColor(.green)

        }
        .onTapGesture {
            withAnimation(Animation.spring()) {
                self.recordBegin.toggle()
            }

            withAnimation(Animation.spring().repeatForever().delay(0.5)) {
                self.recording.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
