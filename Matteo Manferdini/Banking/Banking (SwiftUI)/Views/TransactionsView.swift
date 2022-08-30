//
//  AccountView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct TransactionsView: View {
	let account: Account
	
	@EnvironmentObject private var stateController: StateController
	@State private var addingTransaction: Bool = false
	
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

// MARK: - Content
extension TransactionsView {
	struct Content: View {
		let account: Account
		let newTransaction: () -> Void
		
		var body: some View {
			VStack {
				List(transactions) { transaction in
					Row(transaction: transaction)
				}
				AddButton(title: "New Transaction", action: newTransaction)
			}
			.navigationBarTitle(account.name)
		}
		
		var transactions: [Transaction] {
			account.transactions.sorted(by: { $0.date >= $1.date })
		}
	}
}

// MARK: - Row
extension TransactionsView.Content {
	struct Row: View {
		let transaction: Transaction
		
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

struct AccountView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NavigationView {
				TransactionsView.Content(account: TestData.account, newTransaction: {})
			}
		}
	}
}
