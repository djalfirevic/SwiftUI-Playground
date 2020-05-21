//
//  ContentView.swift
//  SwiftUIScrollView
//
//  Created by Djuro Alfirevic on 4/12/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //VerticalView()
        HorizontalView()
    }
}

struct VerticalView: View {
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    VStack(alignment: .leading) {
                        Text("MONDAY, AUG 20")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Your Reading")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.black)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding([.top, .horizontal])
                .layoutPriority(-100)
                
                VStack {
                    CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Djuro Alfirevic")
                    CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Djuro Alfirevic")
                    CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Djuro Alfirevic")
                    CardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Djuro Alfirevic")
                }
            }
            
            Spacer()
        }
    }
}

struct HorizontalView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("MONDAY, AUG 20")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Your Reading")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.black)
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                .padding([.top, .horizontal])
                .layoutPriority(-100)
                
                HStack {
                    CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Djuro Alfirevic")
                        .frame(width: 300)
                    CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Djuro Alfirevic")
                        .frame(width: 300)
                    CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Djuro Alfirevic")
                        .frame(width: 300)
                    CardView(image: "natural-language-api", category: "iOS", heading: "What's New in Natural Language API", author: "Djuro Alfirevic")
                        .frame(width: 300)
                }
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
