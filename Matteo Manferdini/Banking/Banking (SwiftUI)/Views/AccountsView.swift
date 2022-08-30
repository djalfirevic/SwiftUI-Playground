//
//  ContentView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 11/03/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct AccountsView: View {
	@EnvironmentObject private var stateController: StateController
	@State private var addingAccount = false
	
	var body: some View {
		NavigationView {
			Content(accounts: $stateController.accounts, newAccount: { self.addingAccount = true })
		}
		.sheet(isPresented: $addingAccount) {
			NavigationView {
				NewAccountView()
			}
			.environmentObject(self.stateController)
		}
    }
}

// MARK: - Content
extension AccountsView {
	struct Content: View {
		@Binding var accounts: [Account]
		let newAccount: () -> Void
		
		var body: some View {
			VStack {
				List {
					ForEach(accounts) { account in
						NavigationLink(destination: TransactionsView(account: account)) {
							Row(account: account)
						}
					}
					.onMove(perform: move(fromOffsets:toOffset:))
				}
				AddButton(title: "New Account", action: newAccount)
			}
			.navigationBarTitle("Accounts")
			.navigationBarItems(trailing: EditButton())
		}
		
		func move(fromOffsets source: IndexSet, toOffset destination: Int) {
			accounts.move(fromOffsets: source, toOffset: destination)
		}
	}
}

// MARK: - Row
extension AccountsView.Content {
	struct Row: View {
		let account: Account
		
		var body: some View {
			VStack(alignment: .leading, spacing: 4.0) {
				HStack {
					Text(account.name)
						.font(.headline)
					Spacer()
					Text(account.balance.currencyFormat)
						.font(.headline)
				}
				Text("\(account.kind.rawValue.capitalized) account")
					.font(.subheadline)
					.foregroundColor(.secondary)
				Text(account.iban.ibanFormat)
					.font(.caption)
					.foregroundColor(.secondary)
			}
			.padding(.vertical, 8.0)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			AccountsView.Content(accounts: .constant([TestData.account]), newAccount: {})
		}
	}
}
