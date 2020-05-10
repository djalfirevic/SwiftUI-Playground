//
//  AccountsView.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct AccountsView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var stateController: StateController
    @State private var addingAccount = false
    
    // MARK: - Body
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

extension AccountsView {
    struct Content: View {
        
        // MARK: - Properties
        @Binding var accounts: [Account]
        let newAccount: () -> Void
        
        // MARK: - Body
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
        
        // MARK: - Public API
        func move(fromOffsets source: IndexSet, toOffset destination: Int) {
            accounts.move(fromOffsets: source, toOffset: destination)
        }
        
    }
}

extension AccountsView.Content {
    struct Row: View {
        
        // MARK: - Properties
        let account: Account
        
        // MARK: - Body
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

struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountsView.Content(accounts: .constant([TestData.account]), newAccount: {})
        }
    }
}
