//
//  NewAccountView.swift
//  Banking (SwiftUI)
//
//  Created by Matteo Manferdini on 01/04/2020.
//  Copyright © 2020 Matteo Manferdini. All rights reserved.
//

import SwiftUI

struct NewAccountView: View {
	@EnvironmentObject private var stateController: StateController
	@Environment(\.presentationMode) private var presentationMode
	@State private var name: String = ""
	@State private var kind: Account.Kind = .checking
	
	var body: some View {
		Content(name: $name, kind: $kind, create: create, cancel: dismiss)
	}
	
	func create() {
		stateController.addAccount(named: name, withKind: kind)
		dismiss()
	}
	
	func dismiss() {
		presentationMode.wrappedValue.dismiss()
	}
}

// MARK: - Content
extension NewAccountView {
	struct Content: View {
		@Binding var name: String
		@Binding var kind: Account.Kind
		
		let create: () -> Void
		let cancel: () -> Void

		var body: some View {
			List {
				TextField("Account name", text: $name)
				Picker("Kind", selection: $kind) {
					ForEach(Account.Kind.allCases, id: \.self) { kind in
						Text(kind.rawValue).tag(kind)
					}
				}
				Spacer()
			}
			.padding(.top)
			.navigationBarTitle("New Account")
			.navigationBarItems(leading: cancelButton, trailing: createButton)
		}
		
		var cancelButton: some View {
			Button(action: cancel) {
				Text("Cancel")
			}
		}
		
		var createButton: some View {
			Button(action: create) {
				Text("Create")
					.bold()
			}
		}
	}
}

struct NewAccountView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			NewAccountView.Content(name: .constant(""), kind: .constant(.checking), create: {}, cancel: {})
		}
	}
}
