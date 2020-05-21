//
//  ContentView.swift
//  SwiftUIStacksExercise
//
//  Created by Djuro Alfirevic on 4/11/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            PricingView(title: "Basic", price: "$19", textColor: .white, bgColor: .purple, icon: "burst.fill")
                .padding()
                .offset(x: 0, y: -220)
            
            PricingView(title: "Pro", price: "$19", textColor: .white, bgColor: Color(red: 255/255, green: 183/255, blue: 37/255), icon: "dial")
                .padding()
                .offset(x: 0, y: -110)
            
            PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PricingView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?
    
    var body: some View {
        VStack {
            icon.map({
                Image(systemName: $0)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            })
            
            Text(title)
                .font(.system(.title))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}
