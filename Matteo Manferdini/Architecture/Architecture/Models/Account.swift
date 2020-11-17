//
//  Account.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Account: Codable, Identifiable {
    
    // MARK: - Properties
    let name: String
    let iban: String
    let kind: Kind
    private(set) var transactions: [Transaction]
    
    var id: String { iban }
    var balance: Int {
        return transactions.reduce(0) { $0 + $1.amount }
    }
    
    // MARK: - Initializer
    init(name: String, iban: String, kind: Kind) {
        self.name = name
        self.iban = iban
        self.kind = kind
        transactions = [
            Transaction(amount: 2000_00, beneficiary: "Initial Balance", date: Date())
        ]
    }
    
    // MARK: - Public API
    mutating func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
}

extension Account {
    enum Kind: String, Codable, CaseIterable {
        case checking, savings, investment
    }
}
