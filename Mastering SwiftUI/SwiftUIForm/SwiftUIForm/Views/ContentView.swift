//
//  ContentView.swift
//  SwiftUIForm
//
//  Created by Djuro Alfirevic on 4/23/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", phone: "232-923423", image: "cafedeadend", priceLevel: 3),
        Restaurant(name: "Homei", type: "Cafe", phone: "348-233423", image: "homei", priceLevel: 3),
        Restaurant(name: "Teakha", type: "Tea House", phone: "354-243523", image: "teakha", priceLevel: 3, isFavorite: true, isCheckIn: true),
        Restaurant(name: "Cafe loisl", type: "Austrian / Casual Drink", phone: "453-333423", image: "cafeloisl", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Restaurant(name: "Petite Oyster", type: "French", phone: "983-284334", image: "petiteoyster", priceLevel: 5, isCheckIn: true),
        Restaurant(name: "For Kee Restaurant", type: "Hong Kong", phone: "232-434222", image: "forkeerestaurant", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Restaurant(name: "Po's Atelier", type: "Bakery", phone: "234-834322", image: "posatelier", priceLevel: 4),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", phone: "982-434343", image: "bourkestreetbakery", priceLevel: 4, isCheckIn: true),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", phone: "734-232323", image: "haighschocolate", priceLevel: 3, isFavorite: true),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", phone: "872-734343", image: "palominoespresso", priceLevel: 2),
        Restaurant(name: "Upstate", type: "Seafood", phone: "343-233221", image: "upstate", priceLevel: 4),
        Restaurant(name: "Traif", type: "American", phone: "985-723623", image: "traif", priceLevel: 5),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", phone: "455-232345", image: "grahamavenuemeats", priceLevel: 3),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", phone: "434-232322", image: "wafflewolf", priceLevel: 3),
        Restaurant(name: "Five Leaves", type: "Bistro", phone: "343-234553", image: "fiveleaves", priceLevel: 4, isFavorite: true, isCheckIn: true),
        Restaurant(name: "Cafe Lore", type: "Latin American", phone: "342-455433", image: "cafelore", priceLevel: 2, isFavorite: true, isCheckIn: true),
        Restaurant(name: "Confessional", type: "Spanish", phone: "643-332323", image: "confessional", priceLevel: 4),
        Restaurant(name: "Barrafina", type: "Spanish", phone: "542-343434", image: "barrafina", priceLevel: 2, isCheckIn: true),
        Restaurant(name: "Donostia", type: "Spanish", phone: "722-232323", image: "donostia", priceLevel: 1),
        Restaurant(name: "Royal Oak", type: "British", phone: "343-988834", image: "royaloak", priceLevel: 2, isFavorite: true),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", phone: "432-344050", image: "caskpubkitchen", priceLevel: 1)
    ]
    
    @State private var selectedRestaurant: Restaurant?
    @State private var showSettings = false
    @EnvironmentObject var settingStore: SettingStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants.sorted(by: self.settingStore.displayOrder.predicate())) { restaurant in
                    if self.shouldShowItem(restaurant: restaurant) {
                        BasicImageRow(restaurant: restaurant)
                            .contextMenu {
                                Button(action: {
                                    // mark the selected restaurant as check-in
                                    self.checkIn(item: restaurant)
                                }) {
                                    HStack {
                                        Text("Check-in")
                                        Image(systemName: "checkmark.seal.fill")
                                    }
                                }
                                
                                Button(action: {
                                    // delete the selected restaurant
                                    self.delete(item: restaurant)
                                }) {
                                    HStack {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                                                 
                                Button(action: {
                                    // mark the selected restaurant as favorite
                                    self.setFavorite(item: restaurant)
                                    
                                }) {
                                    HStack {
                                        Text("Favorite")
                                        Image(systemName: "star")
                                    }
                                }
                            }
                            .onTapGesture {
                                self.selectedRestaurant = restaurant
                            }
                    }
                }
                .onDelete { (indexSet) in
                    self.restaurants.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showSettings = true
                }, label: {
                    Image(systemName: "gear")
                        .font(.title)
                        .foregroundColor(.black)
                })
            )
            .sheet(isPresented: $showSettings) {
                SettingView().environmentObject(self.settingStore)
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
    
    private func shouldShowItem(restaurant: Restaurant) -> Bool {
        return (!self.settingStore.showCheckInOnly || restaurant.isCheckIn) && (restaurant.priceLevel <= self.settingStore.maxPriceLevel)
    }
}

struct BasicImageRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(restaurant.name)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    
                    Text(String(repeating: "$", count: restaurant.priceLevel))
                        .font(.subheadline)
                        .foregroundColor(.gray)

                }
                
                Text(restaurant.type)
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Text(restaurant.phone)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
                .layoutPriority(-100)
            
            if restaurant.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.red)
            }
            
            if restaurant.isFavorite {
//                    Spacer()
                
                Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SettingStore())
    }
}
