//
//  Extensions.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

extension String {
    static func generateIban() -> String {
        func randomString(length: Int, from characters: String) -> String {
            String((0..<length).map{ _ in characters.randomElement()! })
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "0123456789"
        
        return randomString(length: 2, from: letters)
            + randomString(length: 2, from: digits)
            + randomString(length: 4, from: letters)
            + randomString(length: 12, from: digits)
    }
    var ibanFormat: String {
        var remaining = Substring(self)
        var chunks: [Substring] = []
        while !remaining.isEmpty {
            chunks.append(remaining.prefix(4))
            remaining = remaining.dropFirst(4)
        }
        return chunks.joined(separator: " ")
    }
}

extension Int {
    var currencyFormat: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: Float(self) / 100 )) ?? ""
    }
}

extension Date {
    var transactionFormat: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
