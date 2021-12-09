//
//  ContentView.swift
//  PaperCSS
//
//  Created by Djuro on 12/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Card(shape: .shape1) {
                Text("Documentation")
                    .font(Font.custom("ChalkboardSE-Light", fixedSize: 18))
            }
            
            Card(shape: .shape2) {
                Text("About")
                    .font(Font.custom("ChalkboardSE-Light", fixedSize: 18))
            }
            
            Card(shape: .shape3) {
                Text("Links")
                    .font(Font.custom("ChalkboardSE-Light", fixedSize: 18))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
