//
//  GradientTextfield.swift
//  Advanced SwiftUI
//
//  Created by Sai Kambampati on 4/3/21.
//

import SwiftUI

struct GradientTextfield: View {
    @Binding var editingTextfield: Bool
    @Binding var textfieldString: String
    @Binding var iconBounce: Bool
    var textfieldPlaceholder: String
    var textfieldIconString: String
    private let generator = UISelectionFeedbackGenerator()

    var body: some View {
        HStack(spacing: 12) {
            TextfieldIcon(iconName: textfieldIconString, passedImage: .constant(nil), currentlyEditing: $editingTextfield)
                .scaleEffect(iconBounce ? 1.2 : 1.0)
            TextField(textfieldPlaceholder, text: $textfieldString) { isEditing in
                generator.selectionChanged()
                editingTextfield = isEditing
                if isEditing {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                        iconBounce.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0.5)) {
                            iconBounce.toggle()
                        }
                    }
                }
            }
            .colorScheme(.dark)
            .foregroundColor(Color.white.opacity(0.7))
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .background(
            Color.init(red: 26/255, green: 20/255, blue: 51/255)
                .cornerRadius(16)
        )
    }
}
