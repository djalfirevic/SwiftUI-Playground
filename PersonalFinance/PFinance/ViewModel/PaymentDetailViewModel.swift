//
//  PaymentDetailViewModel.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct PaymentDetailViewModel {
    var payment: PaymentActivity
    
    var name: String {
        return payment.name
    }
    
    var date: String {
        return payment.date.string()
    }
    
    var address: String {
        return payment.address ?? ""
    }
    
    var typeIcon: String {
        let icon: String
        
        switch payment.type {
        case .income: icon = "arrowtriangle.up.circle.fill"
        case .expense: icon = "arrowtriangle.down.circle.fill"
        }
        
        return icon
    }
    
    var image: String = "payment-detail"
    
    var amount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        
        let formattedValue = formatter.string(from: NSNumber(value: payment.amount)) ?? ""
        
        let formattedAmount = ((payment.type == .income) ? "+" : "-") + "$" + formattedValue
        
        return formattedAmount
    }
    
    var memo: String {
        return payment.memo ?? ""
    }
    
    init(payment: PaymentActivity) {
        self.payment = payment
    }
}
