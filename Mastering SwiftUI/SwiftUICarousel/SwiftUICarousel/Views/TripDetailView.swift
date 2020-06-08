//
//  TripDetailView.swift
//  SwiftUICarousel
//
//  Created by Djuro Alfirevic on 6/8/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct TripDetailView: View {
    let destination: String
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(self.destination)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.heavy)
                            
                            HStack(spacing: 3) {
                                ForEach(1...5, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 15))
                                }
                                
                                Text("5.0")
                                    .font(.system(.headline))
                                    .padding(.leading, 10)
                            }
                            
                        }
                        .padding(.bottom, 30)
                        
                        
                        Text("Description")
                            .font(.system(.headline))
                            .fontWeight(.medium)
                        
                        Text("Growing up in Michigan, I was lucky enough to experience one part of the Great Lakes. And let me assure you, they are great. As a photojournalist, I have had endless opportunities to travel the world and to see a variety of lakes as well as each of the major oceans. And let me tell you, you will be hard pressed to find water as beautiful as the Great Lakes.")
                            .padding(.bottom, 40)
                        
                        Button(action: {
                            // tap me
                        }) {
                            Text("Book Now")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .background(Color(red: 0.97, green: 0.369, blue: 0.212))
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    .background(Color.white)
                    .cornerRadius(15)
                    
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.97, green: 0.369, blue: 0.212))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: -15, y: -5)
                }
                .offset(y: 15)
            }
        }

    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(destination: "London").background(Color.black)
    }
}
