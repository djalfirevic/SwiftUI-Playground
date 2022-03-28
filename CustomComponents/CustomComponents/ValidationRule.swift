//
//  ValidationRule.swift
//  CustomComponents
//
//  Created by Djuro on 3/28/22.
//

import Foundation

protocol ValidationRule {
    func isValid(value: Any?) -> Bool
}

struct MonthValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        
        let monthRegEx = #"^(0[1-9]|1[0-2])$"#
        let monthPred = NSPredicate(format:"SELF MATCHES %@", monthRegEx)
        return monthPred.evaluate(with: value)
    }
    
}

struct DayValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        
        let dayRegEx = #"^(0[1-9]|[12][0-9]|3[01])$"#
        let dayPred = NSPredicate(format:"SELF MATCHES %@", dayRegEx)
        return dayPred.evaluate(with: value)
    }
    
}

struct YearValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        let year = Calendar.current.component(.year, from: Date())
        let yearRegEx = "^(19[0-9][0-9]|20[01][0-9]|\(year))$"
        let yearPred = NSPredicate(format:"SELF MATCHES %@", yearRegEx)
        return yearPred.evaluate(with: value)
    }
    
}

struct FullDate18Validation: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? Date else { return false }
        let date18YearsAgo = Calendar.current.date(byAdding: DateComponents(year: -18, day: -1), to: Date())!
        return isSameDay(date1: value, date2: date18YearsAgo) || value <= date18YearsAgo
    }
    
    // MARK: - Private API
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        return Calendar.current.dateComponents([.day], from: date1, to: date2).day == 0
    }
    
}

struct NoValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool { true }
    
}

struct SSNValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        
        let regex = #"^(?!666|000|9\d{2})\d{3}-(?!00)\d{2}-(?!0{4})\d{4}$"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
}

struct PhoneNoValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        
        let regex = #"^\+1[0-9]{10}"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
}

struct EmailValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty else { return false }
        
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
}

struct NameValidationRule: ValidationRule {
    
    // MARK: - Properties
    let allowEmptyValue: Bool
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String else { return false }
        
        if allowEmptyValue, value.isEmpty { return true }
        guard !value.isEmpty else { return false }
        
        let regex = #"^(?=.{1,40}$)[a-zA-Z]+(?:[-'\s][a-zA-Z]+)*$"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: value)
    }
    
}

struct DoubleValueValidationRule: ValidationRule {
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, let _ = Double(value) else {
            return false
        }
        
        return true
    }
    
}

struct IncomeValidationRule: ValidationRule {
    
    // MARK: - Properties
    let minimumAllowedIncome = 18000
    
    // MARK: - ValidationRule
    func isValid(value: Any?) -> Bool {
        guard let value = value as? String, !value.isEmpty, let doubleValue = Int(value.filter("0123456789".contains)) else { return false }
        return doubleValue >= minimumAllowedIncome
    }
    
}
