//
//  CustomTextField.swift
//  CustomComponents
//
//  Created by Djuro on 3/28/22.
//

import SwiftUI
import UIKit

enum CustomTextFieldStyle {
    case primaryTextField
    case primarySearchTextField
    case secondarySearchTextField
}

struct CustomTextField<T: View>: View {
    
    // MARK: - Properties
    @Binding var text: String
    @Binding var isValid: Bool
    var label: String?
    var placeholder = ""
    var fontSize: FontSize = .body
    var fontStyle: FontStyle = .regular
    var validationRule: ValidationRule?
    var formatter: CustomTextFieldFormatter?
    var useFormattedValue = false
    var isSecureEntry = false
    var keyboardType = UIKeyboardType.default
    var textContentType: UITextContentType?
    var textAlignment: TextAlignment = .leading
    var footerContent: T
    
    // MARK: - Initializer
    init(text: Binding<String>,
         isValid: Binding<Bool>,
         label: String? = nil,
         placeholder: String = "",
         fontSize: FontSize = .body,
         fontStyle: FontStyle = .regular,
         validationRule: ValidationRule?,
         formatter: CustomTextFieldFormatter?,
         useFormattedValue: Bool = false,
         isSecureEntry: Bool = false,
         keyboardType: UIKeyboardType = .default,
         textContentType: UITextContentType? = nil,
         textAlignment: TextAlignment = .leading,
         @ViewBuilder footerViewContent: () -> T) {
        self._text = text
        self._isValid = isValid
        self.placeholder = placeholder
        self.label = label
        self.fontSize = fontSize
        self.fontStyle = fontStyle
        self.validationRule = validationRule
        self.formatter = formatter
        self.useFormattedValue = useFormattedValue
        self.isSecureEntry = isSecureEntry
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.textAlignment = textAlignment
        self.footerContent = footerViewContent()
    }
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label ?? "")
                .foregroundColor(.red)
                .isHidden(label == nil)
            
            CustomUITextFieldRepresentable(text: $text,
                                           isValid: $isValid,
                                           validationRule: validationRule,
                                           formatter: formatter,
                                           useFormattedValue: useFormattedValue)
            .font(fontStyle, fontSize: fontSize)
            .isSecureEntry(isSecureEntry)
            .placeholder(placeholder)
            .keyboardType(keyboardType)
            .textContentType(textContentType)
            .multilineTextAlignment(textAlignment)
            .frame(height: 44)
            
            footerContent
        }
    }
}

fileprivate struct CustomUITextFieldRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    @Binding var text: String
    @Binding var isValid: Bool
    var placeholder: String?
    var validationRule: ValidationRule?
    var formatter: CustomTextFieldFormatter?
    var useFormattedValue: Bool
    var didBeginEditing: () -> Void = { }
    var didChange: () -> Void = { }
    var didEndEditing: () -> Void = { }
    var font: UIFont?
    var foregroundColor: UIColor?
    var accentColor: UIColor?
    var textAlignment: NSTextAlignment?
    var contentType: UITextContentType?
    var autocorrection: UITextAutocorrectionType = .default
    var autocapitalization: UITextAutocapitalizationType = .none
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var characterLimit: Int?
    var isSecureEntry = false
    var isUserInteractionEnabled = true
    var clearsOnBeginEditing = false
    var clearsOnInsertion = false
    var clearButtonMode: UITextField.ViewMode = .never
    var passwordRules: UITextInputPasswordRules?
    var smartDashesType: UITextSmartDashesType = .default
    var smartInsertDeleteType: UITextSmartInsertDeleteType = .default
    var smartQuotesType: UITextSmartQuotesType = .default
    var spellCheckingType: UITextSpellCheckingType = .default
    @Environment(\.layoutDirection) var layoutDirection: LayoutDirection
    
    // MARK: - Initializer
    init(text: Binding<String>,
         isValid: Binding<Bool>,
         validationRule: ValidationRule? = nil,
         formatter: CustomTextFieldFormatter? = nil,
         useFormattedValue: Bool = false) {
        self._text = text
        self._isValid = isValid
        self.validationRule = validationRule
        self.formatter = formatter
        self.useFormattedValue = useFormattedValue
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text,
                    isValid: $isValid,
                    validationRule: validationRule,
                    formatter: formatter,
                    useFormattedValue: useFormattedValue,
                    isSecureEntry: isSecureEntry,
                    characterLimit: characterLimit,
                    didBeginEditing: didBeginEditing,
                    didChange: didChange,
                    didEndEditing: didEndEditing)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        
        setProperties(textField)
        
        return textField
    }
    
    func updateUIView(_ view: UITextField, context: Context) {
        setProperties(view)
        context.coordinator.update(view)
    }
    
    private func setProperties(_ textField: UITextField) {
        if let textAlignment = textAlignment {
            textField.textAlignment = textAlignment
        }
        
        if let contentType = contentType {
            textField.textContentType = contentType
        }
        
        if let accentColor = accentColor {
            textField.tintColor = accentColor
        }
        
        textField.placeholder = placeholder
        textField.font = font
        textField.clearsOnBeginEditing = clearsOnBeginEditing
        textField.clearsOnInsertion = clearsOnInsertion
        textField.clearButtonMode = clearButtonMode
        textField.autocorrectionType = autocorrection
        textField.autocapitalizationType = autocapitalization
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.isUserInteractionEnabled = isUserInteractionEnabled
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.passwordRules = passwordRules
        textField.smartDashesType = smartDashesType
        textField.smartInsertDeleteType = smartInsertDeleteType
        textField.smartQuotesType = smartQuotesType
        textField.spellCheckingType = spellCheckingType
    }
}

extension CustomUITextFieldRepresentable {
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        
        // MARK: - Properties
        @Binding private var text: String
        @Binding private var isValid: Bool
        private var validationRule: ValidationRule?
        private var formatter: CustomTextFieldFormatter?
        private var useFormattedValue: Bool
        private var isSecureEntry: Bool
        private var characterLimit: Int?
        private var didBeginEditing: () -> Void
        private var didChange: () -> Void
        private var didEndEditing: () -> Void
        private var inputValue = ""
        private var displayValue = ""
        private var isEditing = false
        private var isFilled = false
        private var isInputValid: Bool
        
        // MARK: - Initializer
        init(text: Binding<String>,
             isValid: Binding<Bool>,
             validationRule: ValidationRule?,
             formatter: CustomTextFieldFormatter?,
             useFormattedValue: Bool,
             isSecureEntry: Bool,
             characterLimit: Int?,
             didBeginEditing: @escaping () -> Void,
             didChange: @escaping () -> Void,
             didEndEditing: @escaping () -> Void) {
            self._text = text
            self._isValid = isValid
            self.validationRule = validationRule
            self.formatter = formatter
            self.useFormattedValue = useFormattedValue
            self.isSecureEntry = isSecureEntry
            self.characterLimit = characterLimit
            self.didBeginEditing = didBeginEditing
            self.didChange = didChange
            self.didEndEditing = didEndEditing
            self.isInputValid = isValid.wrappedValue
            
            super.init()
            
            if let formatter = formatter {
                let initialValue = formatter.unformattedText(text.wrappedValue)
                inputValue = initialValue
            } else {
                inputValue = text.wrappedValue
            }
            
            self.isValid = isInputValid(text: inputValue)
        }
        
        // MARK: - Public API
        func update(_ textField: UITextField) {
            var displayValue: String
            if let formatter = formatter {
                let formattedDisplayValue = formatter.formattedText(inputValue)
                displayValue = formattedDisplayValue
            } else {
                let formattedDisplayValue = isSecureEntry ? String(inputValue.map { _ in "●" }) : inputValue
                displayValue = formattedDisplayValue
            }
            textField.text = displayValue
            textField.textColor = textColor
        }
        
        // MARK: - Private API
        private var textColor: UIColor {
            let inputColor = isInputValid ? Color.blue : Color.red
            return UIColor((isEditing || !isFilled) ? .green : inputColor)
        }
        
        private var borderColor: UIColor {
            UIColor(.gray)
        }
        
        private func isInputValid(text: String) -> Bool {
            guard let validationRule = validationRule else { return true }
            let validationResult = validationRule.isValid(value: text)
            return validationResult
        }
        
        // MARK: - UITextFieldDelegate
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                // Update values on change
                update(textField)
                
                // Publish values
                if let formatter = formatter {
                    let value = useFormattedValue ? formatter.formattedText(inputValue) : formatter.unformattedText(inputValue)
                    text = value
                } else {
                    text = inputValue
                }
                
                isValid = isInputValid(text: inputValue)
                
                // Notify change
                didChange()
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                if !isEditing {
                    isEditing = true
                }
                
                if textField.clearsOnBeginEditing {
                    inputValue = ""
                }
                
                didBeginEditing()
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async { [self] in
                if isEditing {
                    isEditing = false
                }
                
                didEndEditing()
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            func updatedUserInput(currentInput: String, input: String) -> String {
                guard let char = input.cString(using: String.Encoding.utf8) else { return currentInput }
                let isBackSpace = strcmp(char, "\\b")
                if isBackSpace == -92 {
                    return String(currentInput.dropLast())
                } else {
                    return currentInput.appending(input)
                }
            }
            
            if let limit = characterLimit, let text = textField.text {
                if text.count + string.count > limit {
                    return false
                }
            }
            
            let updatedUserInput = updatedUserInput(currentInput: inputValue, input: string)
            if let formatter = formatter {
                inputValue = formatter.unformattedText(updatedUserInput)
            } else {
                inputValue = updatedUserInput
            }
            
            isFilled = textField.text?.isEmpty ?? false
            
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
        
    }
    
}

extension CustomUITextFieldRepresentable {
    func placeholder(_ placeholder: String?) -> CustomUITextFieldRepresentable {
        var view = self
        view.placeholder = placeholder
        return view
    }
    
    func characterLimit(_ limit: Int?) -> CustomUITextFieldRepresentable {
        var view = self
        view.characterLimit = limit
        return view
    }
    
    func font(_ style: FontStyle, fontSize: FontSize) -> CustomUITextFieldRepresentable {
        var view = self
        view.font = .custom(style: style, ofSize: fontSize)
        return view
    }
    
    func foregroundColor(_ color: Color?) -> CustomUITextFieldRepresentable {
        var view = self
        if let color = color {
            view.foregroundColor = UIColor(color)
        }
        return view
    }
    
    func accentColor(_ accentColor: Color?) -> CustomUITextFieldRepresentable {
        var view = self
        if let accentColor = accentColor {
            view.accentColor = UIColor(accentColor)
        }
        return view
    }
    
    func multilineTextAlignment(_ alignment: TextAlignment) -> CustomUITextFieldRepresentable {
        var view = self
        switch alignment {
        case .leading:
            view.textAlignment = layoutDirection ~= .leftToRight ? .left : .right
        case .trailing:
            view.textAlignment = layoutDirection ~= .leftToRight ? .right : .left
        case .center:
            view.textAlignment = .center
        }
        return view
    }
    
    func textContentType(_ textContentType: UITextContentType?) -> CustomUITextFieldRepresentable {
        var view = self
        view.contentType = textContentType
        return view
    }
    
    func disableAutocorrection(_ disable: Bool?) -> CustomUITextFieldRepresentable {
        var view = self
        if let disable = disable {
            view.autocorrection = disable ? .no : .yes
        } else {
            view.autocorrection = .default
        }
        return view
    }
    
    func autocapitalization(_ style: UITextAutocapitalizationType) -> CustomUITextFieldRepresentable {
        var view = self
        view.autocapitalization = style
        return view
    }
    
    func keyboardType(_ type: UIKeyboardType) -> CustomUITextFieldRepresentable {
        var view = self
        view.keyboardType = type
        return view
    }
    
    func returnKeyType(_ type: UIReturnKeyType) -> CustomUITextFieldRepresentable {
        var view = self
        view.returnKeyType = type
        return view
    }
    
    func isSecureEntry(_ isSecure: Bool) -> CustomUITextFieldRepresentable {
        var view = self
        view.isSecureEntry = isSecure
        return view
    }
    
    func clearsOnBeginEditing(_ shouldClear: Bool) -> CustomUITextFieldRepresentable {
        var view = self
        view.clearsOnBeginEditing = shouldClear
        return view
    }
    
    func clearsOnInsertion(_ shouldClear: Bool) -> CustomUITextFieldRepresentable {
        var view = self
        view.clearsOnInsertion = shouldClear
        return view
    }
    
    func showsClearButton(_ showsButton: Bool) -> CustomUITextFieldRepresentable {
        var view = self
        view.clearButtonMode = showsButton ? .always : .never
        return view
    }
    
    func disabled(_ disabled: Bool) -> CustomUITextFieldRepresentable {
        var view = self
        view.isUserInteractionEnabled = !disabled
        return view
    }
    
    func passwordRules(_ rules: UITextInputPasswordRules) -> CustomUITextFieldRepresentable {
        var view = self
        view.isSecureEntry = true
        view.passwordRules = rules
        return view
    }
    
    func smartDashes(_ smartDashes: Bool? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let smartDashes = smartDashes {
            view.smartDashesType = smartDashes ? .yes : .no
        }
        return view
    }
    
    func smartInsertDelete(_ smartInsertDelete: Bool? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let smartInsertDelete = smartInsertDelete {
            view.smartInsertDeleteType = smartInsertDelete ? .yes : .no
        }
        return view
    }
    
    func smartQuotes(_ smartQuotes: Bool? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let smartQuotes = smartQuotes {
            view.smartQuotesType = smartQuotes ? .yes : .no
        }
        return view
    }
    
    func spellChecking(_ spellChecking: Bool? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let spellChecking = spellChecking {
            view.spellCheckingType = spellChecking ? .yes : .no
        }
        return view
    }
    
    func onEditingBegan(perform action: (() -> Void)? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let action = action {
            view.didBeginEditing = action
        }
        return view
    }
    
    func onEdit(perform action: (() -> Void)? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let action = action {
            view.didChange = action
        }
        return view
    }
    
    func onEditingEnded(perform action: (() -> Void)? = nil) -> CustomUITextFieldRepresentable {
        var view = self
        if let action = action {
            view.didEndEditing = action
        }
        return view
    }
}

extension View {
    
    @ViewBuilder
    func isHidden(_ hidden: Bool) -> some View {
        if hidden {
            self.hidden()
        } else {
            self
        }
    }
    
}
