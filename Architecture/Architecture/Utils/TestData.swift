//
//  TestData.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct TestData {
    static let account = Account(name: "Test account", iban: String.generateIban(), kind: .checking)
    static let transaction = Transaction(amount: 123456, beneficiary: "Salary", date: Date())
}
