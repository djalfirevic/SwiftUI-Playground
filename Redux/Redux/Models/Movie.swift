//
//  Movie.swift
//  Redux
//
//  Created by Djuro on 10/7/21.
//

import Foundation

struct MovieResponse: Decodable {
    
    // MARK: - Properties
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
    }
    
}

struct Movie: Decodable {
    
    // MARK: - Properties
    let title: String
    let imdbId: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imdbId = "imdbID"
    }
    
}
