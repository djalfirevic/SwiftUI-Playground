//
//  Utils.swift
//  SwiftUIMovieDb
//
//  Created by Djuro Alfirevic on 23/05/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

class Utils {
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
