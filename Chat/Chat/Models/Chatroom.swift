//
//  Chatroom.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import Foundation

struct Chatroom: Codable, Identifiable {
    
    // MARK: - Properties
    var id: String
    var title: String
    var joinCode: Int
    
}
