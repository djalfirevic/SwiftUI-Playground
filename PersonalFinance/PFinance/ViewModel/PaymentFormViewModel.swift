//
//  PaymentFormViewModel.swift
//  PFinance
//
//  Created by Djuro Alfirevic on 5/5/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation
import Combine

class PaymentFormViewModel: ObservableObject {
    // Input
    @Published var name = ""
    @Published var location = ""
    @Published var amount = ""
    @Published var type = PaymentCategory.expense
    @Published var date = Date.today.string(with: "dd/MM/yyyy")
    @Published var memo = ""
    
    // Output
    @Published var isNameValid = false
    @Published var isAmountValid = true
    @Published var isDateValid = false
    @Published var isMemoValid = true
    @Published var isFormInputValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(paymentActivity: PaymentActivity?) {
        self.name = paymentActivity?.name ?? ""
        self.location = paymentActivity?.address ?? ""
        self.amount = "\(paymentActivity?.amount ?? 0.0)"
        self.memo = paymentActivity?.memo ?? ""
        self.type = paymentActivity?.type ?? .expense
        self.date = (paymentActivity?.date ?? Date.today).string(with: "dd/MM/yyyy")
        
        $name
            .receive(on: RunLoop.main)
            .map { name in
                return name.count > 0
            }
            .assign(to: \.isNameValid, on: self)
            .store(in: &cancellableSet)
                
        $date
            .receive(on: RunLoop.main)
            .map { date in
                return Date.fromString(string: date, with: "dd/MM/yyyy") != nil
            }
            .assign(to: \.isDateValid, on: self)
            .store(in: &cancellableSet)
        
        $amount
            .receive(on: RunLoop.main)
            .map { amount in
                guard let validAmount = Double(amount) else {
                    return false
                }
                return validAmount > 0
            }
            .assign(to: \.isAmountValid, on: self)
            .store(in: &cancellableSet)
        
        $memo
            .receive(on: RunLoop.main)
            .map { memo in
                return memo.count < 300
            }
            .assign(to: \.isMemoValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest4($isNameValid, $isDateValid, $isAmountValid, $isMemoValid)
            .receive(on: RunLoop.main)
            .map { (isNameValid, isDateValid, isAmountValid, isMemoValid) in
                return isNameValid && isDateValid && isAmountValid && isMemoValid
            }
            .assign(to: \.isFormInputValid, on: self)
            .store(in: &cancellableSet)
    }
}
