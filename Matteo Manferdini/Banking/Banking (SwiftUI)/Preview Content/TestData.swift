//
//  TestData.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import Foundation

struct TestData {
	static let account = Account(name: "Test account", iban: String.generateIban(), kind: .checking)
	static let transaction = Transaction(amount: 123456, beneficiary: "Salary", date: Date())
}
