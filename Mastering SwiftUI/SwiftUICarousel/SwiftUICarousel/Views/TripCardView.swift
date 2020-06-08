//
//  TripCardView.swift
//  SwiftUICarousel
//
//  Created by Djuro Alfirevic on 6/8/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct TripCardView: View {
    let destination: String
    let imageName: String
    @Binding var isShowDetails: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(self.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(self.isShowDetails ? 0 : 15)
                    .overlay(
                        Text(self.destination)
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(10)
                            .background(Color.white)
                            .padding([.bottom, .leading])
                            .opacity(self.isShowDetails ? 0.0 : 1.0)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                    )
            }
        }
    }
}

struct TripCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripCardView(destination: "London", imageName: "london", isShowDetails: .constant(false))
    }
}
