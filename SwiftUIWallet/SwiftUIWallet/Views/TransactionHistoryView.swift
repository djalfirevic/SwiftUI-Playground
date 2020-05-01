//
//  TransactionHistoryView.swift
//  SwiftUIWallet
//
//  Created by Djuro Alfirevic on 5/1/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct TransactionHistoryView: View {
    var transactions: [Transaction]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Transaction History")
                .font(.system(size: 25, weight: .black, design: .rounded))
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                }
                .padding()
            }
        }
    }
}

struct TransactionView: View {
    var transaction: Transaction
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(UIColor.systemGray5))
            .overlay(
                VStack {
                    Spacer()
                    
                    Image(systemName: transaction.icon)
                        .font(.system(size: 50))
                        .padding(.bottom, 10)
                    
                    Text(transaction.merchant)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    
                    Text("$\(String(format: "%.1f", transaction.amount))")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .padding(.bottom, 30)
                    
                    Text(transaction.date)
                        .font(.system(.caption, design: .rounded))
                    
                    Spacer()
                }
                    
            )
            .frame(width: 200, height: 300)
            
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionHistoryView(transactions: testTransactions)
            TransactionView(transaction: testTransactions[0]).previewLayout(.sizeThatFits)
        }
    }
}

