//
//  Message.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import Foundation

struct Message: Codable, Identifiable {
    
    // MARK: - Properties
    var id: String?
    var content: String
    var name: String
    
}
