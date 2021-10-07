//
//  ContentView.swift
//  Dismissable
//
//  Created by Djuro on 10/7/21.
//

import SwiftUI

struct A: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            Text("A")
                .padding()
//            NavigationLink(
//                destination: B(),
//                isActive: $isActive,
//                label: {
//                    Text("Go to View B")
//                })
            NavigationLink(
                destination: B(isActive: $isActive),
                isActive: $isActive,
                label: {
                    Text("Go to View B")
                })
        }
    }
}

struct B: View {
//    @State private var isActive = false
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("B")
                .padding()
//            NavigationLink(
//                destination: C(isActive: $isActive),
//                isActive: $isActive,
//                label: {
//                    Text("Go to View C")
//                })
            NavigationLink("Go to View C", destination: C(isActive: $isActive))
        }
    }
}

struct C: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("C")
                .padding()
            NavigationLink("Go to View D", destination: D(isActive: $isActive))
        }
    }
}

struct D: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("D")
                .padding()
            NavigationLink("Go to View E", destination: E(isActive: $isActive))
        }
    }
}

struct E: View {
    @Binding var isActive: Bool
    
    var body: some View {
        VStack {
            Text("E")
                .padding()
            Button("Back") {
                isActive = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            A()
        }
    }
}
