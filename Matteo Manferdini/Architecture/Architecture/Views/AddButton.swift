//
//  AddButton.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    
    // MARK: - Properties
    let title: String
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text(title)
                        .font(.headline)
                }
            }
            .padding(.trailing, 20.0)
        }
    }
    
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            AddButton(title: "Add Item", action: {})
        }
    }
}
