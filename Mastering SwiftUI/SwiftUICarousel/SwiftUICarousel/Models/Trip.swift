//
//  Trip.swift
//  SwiftUICarousel
//
//  Created by Djuro Alfirevic on 6/8/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Trip: Identifiable {
    var id = UUID()
    var destination: String
    var image: String
}

#if DEBUG
let sampleTrips = [
    Trip(destination: "Paris", image: "paris"),
    Trip(destination: "Florence", image: "florence"),
    Trip(destination: "Amsterdam", image: "amsterdam"),
    Trip(destination: "Ghent", image: "ghent"),
    Trip(destination: "Santorini", image: "santorini"),
    Trip(destination: "Budapest", image: "budapest"),
    Trip(destination: "London", image: "london"),
    Trip(destination: "Cuba", image: "cuba"),
    Trip(destination: "Osaka", image: "osaka"),
    Trip(destination: "Kyoto", image: "kyoto"),
    Trip(destination: "Seoul", image: "seoul"),
    Trip(destination: "Sydney", image: "sydney"),
    Trip(destination: "Hong Kong", image: "hongkong")
]
#endif

