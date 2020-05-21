//
//  ContentView.swift
//  SwiftUIActionSheet
//
//  Created by Djuro Alfirevic on 4/27/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var restaurants = [
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
        Restaurant(name: "Homei", image: "upstate"),
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
//    @State private var showActionSheet = false
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        List {
            ForEach(restaurants) { restaurant in
                BasicImageRow(restaurant: restaurant)
                    .contextMenu {
                        Button(action: {
                            self.checkIn(item: restaurant)
                        }) {
                            HStack {
                                Text("Check-in")
                                Image(systemName: "checkmark.seal.fill")
                            }
                        }
                        
                        Button(action: {
                            self.delete(item: restaurant)
                        }) {
                            HStack {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                                         
                        Button(action: {
                            self.setFavorite(item: restaurant)
                        }) {
                            HStack {
                                Text("Favorite")
                                Image(systemName: "star")
                            }
                        }
                    }
                    .onTapGesture {
//                        self.showActionSheet.toggle()
                        self.selectedRestaurant = restaurant
                    }
                    .actionSheet(item: self.$selectedRestaurant) { _ in
                        ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [
                            .default(Text("Mark as Favorite"), action: {
                                if let selectedRestaurant = self.selectedRestaurant {
                                    self.setFavorite(item: selectedRestaurant)
                                }
                            }),
                            .destructive(Text("Delete"), action: {
                                if let selectedRestaurant = self.selectedRestaurant {
                                    self.delete(item: selectedRestaurant)
                                }
                            }),
                            .cancel()
                        ])
                    }
            }
            .onDelete { (indexSet) in
                self.restaurants.remove(atOffsets: indexSet)
            }
        }
    }
    
    private func delete(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants.remove(at: index)
        }
    }
    
    private func setFavorite(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants[index].isFavorite.toggle()
        }
    }
    
    private func checkIn(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurants[index].isCheckIn.toggle()
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
            
            if restaurant.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.red)
            }
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

