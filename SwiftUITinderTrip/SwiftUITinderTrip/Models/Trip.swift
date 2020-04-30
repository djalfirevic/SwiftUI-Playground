//
//  Trip.swift
//  SwiftUITinderTrip
//
//  Created by Djuro Alfirevic on 4/30/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Trip {
    var destination: String
    var image: String
}

#if DEBUG

var trips = [
    Trip(destination: "Yosemite, USA", image: "yosemite-usa"),
    Trip(destination: "Venice, Italy", image: "venice-italy"),
    Trip(destination: "Hong Kong", image: "hong-kong"),
    Trip(destination: "Barcelona, Spain", image: "barcelona-spain"),
    Trip(destination: "Braies, Italy", image: "braies-italy"),
    Trip(destination: "Kanangra, Australia", image: "kanangra-australia"),
    Trip(destination: "Mount Currie, Canada", image: "mount-currie-canada"),
    Trip(destination: "Ohrid, Macedonia", image: "ohrid-macedonia"),
    Trip(destination: "Oia, Greece", image: "oia-greece"),
    Trip(destination: "Palawan, Philippines", image: "palawan-philippines"),
    Trip(destination: "Salerno, Italy", image: "salerno-italy"),
    Trip(destination: "Tokyo, Japan", image: "tokyo-japan"),
    Trip(destination: "West Vancouver, Canada", image: "west-vancouver-canada"),
    Trip(destination: "Singapore", image: "garden-by-bay-singapore"),
    Trip(destination: "Perhentian Islands, Malaysia", image: "perhentian-islands-malaysia")
]

#endif
