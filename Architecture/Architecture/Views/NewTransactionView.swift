//
//  NewTransactionView.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct NewTransactionView: View {
    
    // MARK: - Properties
    let account: Account
    @EnvironmentObject private var stateController: StateController
    @Environment(\.presentationMode) private var presentationMode
    @State private var amount = ""
    @State private var beneficiary = ""
    
    // MARK: - Body
    var body: some View {
        Content(amount: $amount, beneficiary: $beneficiary, cancel: dismiss, send: send)
    }
    
    // MARK: - Public API
    func send() {
        let amount = (Int(self.amount) ?? 0) * 100
        stateController.addTransaction(withAmount: amount, beneficiary: beneficiary, to: account)
        dismiss()
     }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

extension NewTransactionView {
    struct Content: View {
        
        // MARK: - Properties
        @Binding var amount: String
        @Binding var beneficiary: String
        let cancel: () -> Void
        let send: () -> Void
        
        // MARK: - Body
        var body: some View {
            List {
                Amount(amount: $amount)
                TextField("Beneficiary name", text: $beneficiary)
            }
            .navigationBarTitle("New Transaction")
            .navigationBarItems(leading: cancelButton, trailing: sendButton)
        }
        
        // MARK: - Custom Views
        var cancelButton: some View {
            Button(action: cancel) {
                Text("Cancel")
            }
        }
        
        var sendButton: some View {
            Button(action: send) {
                Text("Send")
                    .bold()
            }
        }
    }
}

extension NewTransactionView.Content {
    struct Amount: View {
        
        // MARK: - Properties
        @Binding var amount: String
        
        // MARK: - Body
        var body: some View {
            VStack(alignment: .trailing) {
                Text("Amount")
                    .font(.callout)
                    .foregroundColor(.secondary)
                TextField(0.currencyFormat, text: $amount)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .font(Font.largeTitle.bold())
            }
            .padding()
        }
        
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewTransactionView.Content(amount: .constant(""), beneficiary: .constant(""), cancel: {}, send: {})
        }
    }
}
