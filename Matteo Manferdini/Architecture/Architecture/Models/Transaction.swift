//
//  Transaction.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Transaction: Codable, Identifiable {
    
    // MARK: - Properties
    let id = UUID()
    let amount: Int
    let beneficiary: String
    let date: Date
    
}
