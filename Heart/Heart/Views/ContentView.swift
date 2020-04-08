//
//  ContentView.swift
//  Heart
//
//  Created by Djuro Alfirevic on 4/8/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var colorChange = false
    @State private var sizeChange = false
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "heart.fill")
                .font(.system(size: 200))
                .foregroundColor(colorChange ? .yellow : .red)
                .scaleEffect(sizeChange ? 1.5 : 1)
                .animation(.default)
                .onTapGesture {
                    self.colorChange.toggle()
                }
                .onLongPressGesture {
                    self.sizeChange.toggle()
                }
            Spacer()
            MapView()
                .frame(width: 200, height: 200, alignment: .center)
            Spacer()
        }
    }
}

struct MapView: UIViewRepresentable {
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
