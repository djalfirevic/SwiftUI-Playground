//
//  AddButton.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 03/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct AddButton: View {
	let title: String
	let action: () -> Void
	
	var body: some View {
		HStack {
			Spacer()
			Button(action: action) {
				HStack {
					Image(systemName: "plus.circle.fill")
					Text(title)
				}
				.font(.headline)
			}
			.padding(.trailing, 20.0)
		}
	}
}

struct AddButton_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			Spacer()
			AddButton(title: "Add item", action: {})
		}
	}
}
