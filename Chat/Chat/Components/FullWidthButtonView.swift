//
//  FullWidthButtonView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct FullWidthButtonView: View {
    
    // MARK: - Properties
    let label: String
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .frame(height: 45)
                    .cornerRadius(8.0)
                Text(label)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
        }
    }
    
}

struct FullWidthButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FullWidthButtonView(label: "Test Button", action: {
            print("Button pressed!")
        })
    }
}
