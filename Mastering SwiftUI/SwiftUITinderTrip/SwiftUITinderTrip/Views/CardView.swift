//
//  CardView.swift
//  SwiftUITinderTrip
//
//  Created by Djuro Alfirevic on 4/30/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct CardView: View, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(
                VStack {
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding([.bottom], 20)
            , alignment: .bottom)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "yosemite-usa", title: "Yosemite, USA")
    }
}
