//
//  CustomTextFieldFormatter.swift
//  CustomComponents
//
//  Created by Djuro on 3/28/22.
//

import Foundation

protocol CustomTextFieldFormatter {
    func formattedText(_ text: String) -> String
    func unformattedText(_ text: String) -> String
}

extension CustomTextFieldFormatter {
    func formattedText(_ text: String) -> String { text }
    
    func unformattedText(_ text: String) -> String { text }
}

final class PhoneNoFormatter: CustomTextFieldFormatter {
    
    // MARK: - Properties
    let formatMask: String? = "+X (XXX) XXX-XXXX"
    let areaCode: String = "+1"
    
    // MARK: - CustomTextFieldFormatter
    func formattedText(_ text: String) -> String {
        formattedPhoneNumber(value: text)
    }
    
    func unformattedText(_ text: String) -> String {
        if text.count < 2 {
            return areaCode
        } else {
            let result = text.trimmingCharacters(in: CharacterSet(charactersIn: "+0123456789").inverted)
            return String(result.prefix(12))
        }
    }
    
    // MARK: - Private API
    private func formattedPhoneNumber(value: String) -> String {
        guard let formatMask = formatMask else { return areaCode }
        
        let numbers = value.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for character in formatMask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
}

final class AmountFormatter: Formatter, CustomTextFieldFormatter {
    
    // MARK: - Public API
    func formatted(number: String?) -> String? {
        guard let number = number, let amount = Double(number) else { return number }
        var isWholeNumber: Bool { amount.isZero ? true : !amount.isNormal ? false : amount == amount.rounded() }
        var isLastCharDot: Bool { number.last == "." }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        let result = formatter.string(from: NSNumber(value: amount))
        return result
    }
    
    // MARK: - Formatter
    override func string(for obj: Any?) -> String? {
        if let string = obj as? String {
            return formatted(number: string)
        }
        
        return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject?
        
        return true
    }
    
    // MARK: - CustomTextFieldFormatter
    func formattedText(_ text: String) -> String {
        formatted(number: text) ?? ""
    }
    
    func unformattedText(_ text: String) -> String {
        text.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789."))
    }
    
}

final class CurrencyFormatter: Formatter, CustomTextFieldFormatter {
    
    // MARK: - Properties
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.currencySymbol = currencySymbol
        return formatter
    }()
    let currencySymbol = "$"
    let locale = Locale(identifier: "en_US")
    
    // MARK: - Public API
    func formatted(number: String?) -> String? {
        guard let number = number, let amount = Double(number) else { return currencySymbol }
        var isWholeNumber: Bool { amount.isZero ? true : !amount.isNormal ? false : amount == amount.rounded() }
        var isLastCharDot: Bool { number.last == "." }
        numberFormatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        let result = numberFormatter.string(from: NSNumber(value: amount))
        let returnValue = isLastCharDot ? result! + "." : !isWholeNumber && result?.last == "0" ? String(result!.dropLast()) : result
        return returnValue
    }
    
    // MARK: - Formatter
    override func string(for obj: Any?) -> String? {
        if let string = obj as? String {
            return formatted(number: string)
        }
        
        return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject?
        
        return true
    }
    
    // MARK: - CustomTextFieldFormatter
    func formattedText(_ text: String) -> String {
        formatted(number: text) ?? ""
    }
    
    func unformattedText(_ text: String) -> String {
        guard let value = Double(text) else {
            return String( text.dropLast())
        }
        
        var isWholeNumber: Bool { value.isZero ? true : !value.isNormal ? false : value == value.rounded() }
        var isLastCharDot: Bool { text.last == "." }
        
        if isWholeNumber || isLastCharDot {
            return text
        } else {
            let significantFractionalDecimalDigits = Decimal(value).significantFractionalDecimalDigits
            return significantFractionalDecimalDigits > 2 ? String(text.dropLast()) : text
        }
    }
    
}

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
