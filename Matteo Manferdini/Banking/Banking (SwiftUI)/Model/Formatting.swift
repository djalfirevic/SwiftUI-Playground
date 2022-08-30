//
//  Formatting.swift
//  Budget
//
//  Created by Matteo Manferdini on 06/12/2019.
//  Copyright © 2019 Matteo Manferdini. All rights reserved.
//

import Foundation

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

extension String {
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
