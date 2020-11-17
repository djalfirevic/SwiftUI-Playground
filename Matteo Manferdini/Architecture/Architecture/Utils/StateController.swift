//
//  StateController.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

final class StateController: ObservableObject {
    
    // MARK: - Properties
    @Published var accounts: [Account]
    private let storageController = StorageController()
    
    // MARK: - Initializer
    init() {
        self.accounts = storageController.fetchAccounts()
    }
    
    // MARK: - Public API
    func addAccount(named name: String, withKind kind: Account.Kind) {
        let account = Account(name: name, iban: String.generateIban(), kind: kind)
        accounts.append(account)
        storageController.save(accounts)
    }
     
    func addTransaction(withAmount amount: Int, beneficiary: String, to account: Account) {
        guard let index = accounts.firstIndex(where: { $0.id == account.id }) else { return }
        
        let transaction = Transaction(amount: amount, beneficiary: beneficiary, date: Date())
        accounts[index].add(transaction)
        storageController.save(accounts)
    }
    
}
