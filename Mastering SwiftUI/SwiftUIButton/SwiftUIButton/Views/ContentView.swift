//
//  ContentView.swift
//  SwiftUIButton
//
//  Created by Djuro Alfirevic on 4/13/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Hello World tapped")
            }) {
                Text("Hello World")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(40)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.purple, lineWidth: 5)
                    )
            }
            
            HStack {
                Button(action: {
                    print("Delete tapped")
                }) {
                    Image(systemName: "trash")
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    print("Delete tapped")
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .font(.title)
                        Text("Delete")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    //.shadow(radius: 5.0)
                    .shadow(color: .gray, radius: 20.0, x: 20.0, y: 10)
                }
            }
            
            VStack {
                Button(action: {
                    print("Share tapped")
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                        Text("Share")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
                .buttonStyle(GradientBackgroundStyle())
                
                Button(action: {
                    print("Edit tapped")
                }) {
                    HStack {
                        Image(systemName: "square.and.pencil")
                            .font(.title)
                        Text("Edit")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
                .buttonStyle(GradientBackgroundStyle())
                
                Button(action: {
                    print("Delete tapped")
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .font(.title)
                        Text("Delete")
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
                .buttonStyle(GradientBackgroundStyle())
                
                Button(action: {
                    print("Plus button tapped")
                }) {
                    Image(systemName: "plus")
                }
                .buttonStyle(CircularStyle())
            }
        }
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct CircularStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotationEffect(configuration.isPressed ? Angle(degrees: 135) : Angle(degrees: 0))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
