//
//  ContentView.swift
//  SwiftUINavigationList
//
//  Created by Djuro Alfirevic on 4/21/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var restaurants = [
        Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
        Restaurant(name: "Homei", image: "homei"),
        Restaurant(name: "Teakha", image: "teakha"),
        Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
        Restaurant(name: "Petite Oyster", image: "petiteoyster"),
        Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
        Restaurant(name: "Po's Atelier", image: "posatelier"),
        Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
        Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
        Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
        Restaurant(name: "Upstate", image: "upstate"),
        Restaurant(name: "Traif", image: "traif"),
        Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
        Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
        Restaurant(name: "Five Leaves", image: "fiveleaves"),
        Restaurant(name: "Cafe Lore", image: "cafelore"),
        Restaurant(name: "Confessional", image: "confessional"),
        Restaurant(name: "Barrafina", image: "barrafina"),
        Restaurant(name: "Donostia", image: "donostia"),
        Restaurant(name: "Royal Oak", image: "royaloak"),
        Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")
    ]
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed, .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .black
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                    }
                }
            }
            .navigationBarTitle("Restaurants", displayMode: .automatic)
        }
    }
}

struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    var body: some View {
        VStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
