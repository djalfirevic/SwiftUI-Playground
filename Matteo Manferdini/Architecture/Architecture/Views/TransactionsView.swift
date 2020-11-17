//
//  TransactionsView.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
    
    // MARK: - Properties
    let account: Account
    @EnvironmentObject private var stateController: StateController
    @State private var addingTransaction = false
    
    // MARK: - Body
    var body: some View {
        Content(account: account, newTransaction: { self.addingTransaction = true })
            .sheet(isPresented: $addingTransaction) {
                NavigationView {
                    NewTransactionView(account: self.account)
                        .environmentObject(self.stateController)
                }
        }
    }
    
}

extension TransactionsView.Content {
    struct Row: View {
        
        // MARK: - Properties
        let transaction: Transaction
        
        // MARK: - Body
        var body: some View {
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    Text(transaction.beneficiary)
                        .font(.headline)
                    Spacer()
                    Text(transaction.amount.currencyFormat)
                        .font(.headline)
                }
                Text(transaction.date.transactionFormat)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        
    }
}

extension TransactionsView {
    struct Content: View {
        
        // MARK: - Properties
        let account: Account
        let newTransaction: () -> Void
        var transactions: [Transaction] {
            account.transactions.sorted(by: { $0.date >= $1.date })
        }
        
        // MARK: - Body
        var body: some View {
            VStack {
                List(transactions) { transaction in
                    Row(transaction: transaction)
                }
                AddButton(title: "New Transaction", action: newTransaction)
            }
            .navigationBarTitle(account.name)
        }
        
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(account: TestData.account)
    }
}
