//
//  ContentView.swift
//  Redux
//
//  Created by Djuro on 10/7/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            List(store.state.movies, id: \.imdbId) { movie in
                Text(movie.title)
            }
            
            Button("Get Movies") {
                self.store.dispatch(action: GetMoviesAction())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(store)
    }
}
