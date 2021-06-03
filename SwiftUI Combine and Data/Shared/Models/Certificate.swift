//
//  Certificate.swift
//  SwiftUICombineData
//
//  Created by Stephanie Diep on 2021-05-18.
//

import Foundation

struct Certificate: Identifiable, Decodable {
    var id: String
    var course: String
    var date: String
    var logo: String
    var instructor: String
}
