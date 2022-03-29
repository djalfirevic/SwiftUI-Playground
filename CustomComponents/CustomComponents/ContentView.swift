//
//  ContentView.swift
//  CustomComponents
//
//  Created by Djuro on 3/28/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    @State private var ssn = ""
    @State private var isSSNValid = false
    
    @State private var amountValue = ""
    @State private var isAmountValid = true
    
    @State private var phone = ""
    @State private var isPhoneValid = true
    
    @State private var income = ""
    @State private var isIncomeValid = true
    
    @State private var password = ""
    @State private var isPasswordValid = true
    
    @StateObject private var viewModel = PinViewModel(numberOfDigits: 6, didComplete: .constant(true), didFailToValidate: .constant(false))
    @FocusState private var focusedField: Int?
    
    // MARK: - View
    var body: some View {
        VStack {
            CustomTextField(text: $ssn,
                            isValid: $isSSNValid,
                            label: "Social Security Number",
                            placeholder: "SSN",
                            fontSize: .h3,
                            validationRule: SSNValidationRule(),
                            formatter: nil,
                            useFormattedValue: true,
                            keyboardType: .numberPad) {
                
            }
            
            CustomTextField(text: $amountValue,
                            isValid: $isAmountValid,
                            placeholder: "0.00",
                            fontSize: FontSize.headline,
                            fontStyle: .extraBold,
                            validationRule: DoubleValueValidationRule(),
                            formatter: AmountFormatter(),
                            useFormattedValue: false,
                            isSecureEntry: false,
                            keyboardType: .decimalPad,
                            textAlignment: .leading) {
                Text("Something below")
            }
            
            CustomTextField(text: $phone,
                            isValid: $isPhoneValid,
                            placeholder: "Phone",
                            fontSize: .h3,
                            validationRule: PhoneNoValidationRule(),
                            formatter: PhoneNoFormatter(),
                            useFormattedValue: false,
                            keyboardType: .phonePad,
                            textContentType: .telephoneNumber) {
                
            }
            
            CustomTextField(text: $income,
                            isValid: $isIncomeValid,
                            placeholder: "Income",
                            fontSize: .h3,
                            validationRule: IncomeValidationRule(),
                            formatter: CurrencyFormatter(),
                            useFormattedValue: false,
                            keyboardType: .decimalPad,
                            textContentType: nil) {
                
            }
            
            CustomTextField(text: $password,
                            isValid: $isPasswordValid,
                            placeholder: "Password",
                            fontSize: .h3,
                            validationRule: nil,
                            formatter: nil,
                            useFormattedValue: false,
                            isSecureEntry: true,
                            keyboardType: .decimalPad,
                            textContentType: nil) {
                
            }
            
            HStack(spacing: 16) {
                ForEach(0..<6, id: \.self) { index in
                    PinTextField(isValid: $viewModel.isValid,
                                 text: $viewModel.characters[index],
                                 shouldValidate: $viewModel.shouldValidate,
                                 didEnterValue: {
                        viewModel.didEnterValue(at: index)
                    }, didRemoveValue: {
                        viewModel.didRemoveValue(at: index)
                    }, didBecomeActive: {
                        viewModel.didStartEditing(at: index)
                    })
                    .focused($focusedField, equals: index)
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .onChange(of: viewModel.currentInputIndex) { newValue in
            focusedField = newValue
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                focusedField = viewModel.currentInputIndex
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}