//
//  PinTextField.swift
//  CustomComponents
//
//  Created by Djuro on 3/29/22.
//

import SwiftUI
import Combine

struct PinTextField: View {
    
    // MARK: - Properties
    
    @Binding var isValid: Bool
    @Binding var text: String
    @Binding var shouldValidate: Bool
    
    var didEnterValue: () -> ()
    var didRemoveValue: () -> ()
    var didBecomeActive: () -> ()
    
    @State private var isActive = false
    @State private var isFilled = false
    
    // MARK: - UI
    
    var body: some View {
        ZStack {
            TextField("", text: $text, onEditingChanged: { editing in
                isActive = editing
                if editing {
                    didBecomeActive()
                }
            })
            .onChange(of: text, perform: { newValue in
                isFilled = newValue.count > 0
                if newValue.isEmpty {
                    isFilled = false
                    text = ""
                    didRemoveValue()
                } else {
                    isFilled = true
                    let char = Array(newValue).last
                    let code = "\(char!)"
                    text = code
                    didEnterValue()
                }
            })
            .keyboardType(.numberPad)
            .font(.custom(ofSize: .h3))
            .accentColor(.clear)
            .multilineTextAlignment(.center)
            .background(Color.white)
            .foregroundColor(.clear)
            .frame(width: 40, height: 50)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: !isActive && isFilled ? .gray.opacity(0.50) : .white, radius: 7, x: 0, y: 7)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(borderColor, lineWidth: 2))
            
            Text("●")
                .font(.custom(ofSize: .h3))
                .accentColor(.clear)
                .multilineTextAlignment(.center)
                .background(Color.white)
                .foregroundColor(text.isEmpty ? .clear : .blue)
                .frame(width: 40, height: 50)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: !isActive && isFilled ? .gray.opacity(0.50) : .white, radius: 7, x: 0, y: 7)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(borderColor, lineWidth: 2))
        }
        
    }
    
    // MARK: - Private API
    
    private var borderColor: Color {
        if isFilled && isValid && shouldValidate {
            return .green
        } else if isActive {
            return .blue
        } else if isFilled {
            return .white
        } else {
            return .gray
        }
    }
}

final class PinViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Binding var didComplete: Bool
    @Binding var didFailToValidate: Bool
    @Published var currentInputIndex = 0
    @Published var characters: [String]
    @Published var isValid = false
    @Published var shouldValidate = false
    @Published var loading = false
    private var cancellables = Set<AnyCancellable>()
    private let numberOfDigits: Int
    
    // MARK: - Initializer
    
    init(numberOfDigits: Int = 6,
         didComplete: Binding<Bool>,
         didFailToValidate: Binding<Bool>) {
        self.numberOfDigits = numberOfDigits
        self.characters = Array(repeating: "", count: numberOfDigits)
        self._didComplete = didComplete
        self._didFailToValidate = didFailToValidate
        
        configureBindings()
    }
    
    // MARK: - Public API
    
    func didEnterValue(at index: Int) {
        let newIndex = index + 1
        let indexToSelect = min(newIndex, characters.count - 1)
        currentInputIndex = indexToSelect
    }
    
    func didRemoveValue(at index: Int) {
        let newIndex = currentInputIndex - 1
        let indexToSelect = max(0, newIndex)
        currentInputIndex = indexToSelect
    }
    
    func didStartEditing(at index: Int) {
        currentInputIndex = index
    }
    
    // MARK: - Private API
    
    private func configureBindings() {
        $characters
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { [self] characters in
                let pin = characters.joined()
                let shouldValidate = pin.count == numberOfDigits
                self.shouldValidate = shouldValidate
                
                if shouldValidate {
                    self.checkPin(pin)
                }
            })
            .store(in: &cancellables)
    }
    
    private func checkPin(_ pin: String) {
        loading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loading = false
            self.isValid = true
            self.shouldValidate = false
        }
    }
}
