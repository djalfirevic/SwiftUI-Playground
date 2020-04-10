//
//  ContentView.swift
//  SwiftUIImage
//
//  Created by Djuro Alfirevic on 4/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        Image("paris")
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .edgesIgnoringSafeArea(.all)
//            .frame(width: 300)
//            .clipShape(Circle())
//        .overlay(
//            Image(systemName: "cloud.heavyrain")
//                .font(.system(size: 200))
//                .foregroundColor(.black)
//                .opacity(0.5)
//        )
        
        Image("paris")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
        .overlay(
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
            .overlay(
                Text("Paris")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .frame(width: 200)
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
