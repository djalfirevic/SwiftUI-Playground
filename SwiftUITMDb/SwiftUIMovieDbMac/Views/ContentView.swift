//
//  ContentView.swift
//  SwiftUIMovieDbMac
//
//  Created by Djuro Alfirevic on 20/06/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootView()
            .frame(minWidth: 1016, maxWidth: .infinity, minHeight: 556, maxHeight: .infinity)
    }
}

struct RootView: View {
    var body: some View {
        NavigationView {
            NavigationMenuView()
            HomeView()
        }.navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


