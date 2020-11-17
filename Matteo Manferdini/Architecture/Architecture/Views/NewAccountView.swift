//
//  NewAccountView.swift
//  Architecture
//
//  Created by Djuro Alfirevic on 5/10/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct NewAccountView: View {

    // MARK: - Properties
    @EnvironmentObject private var stateController: StateController
    @Environment(\.presentationMode) private var presentationMode
    @State private var name = ""
    @State private var kind = Account.Kind.checking
    
    // MARK: - Body
    var body: some View {
        Content(name: $name, kind: $kind, create: create, cancel: dismiss)
    }
    
    // MARK - Public API
     func create() {
        stateController.addAccount(named: name, withKind: kind)
        dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

extension NewAccountView {
    struct Content: View {
        
        // MARK: - Properties
        @Binding var name: String
        @Binding var kind: Account.Kind
        let create: () -> Void
        let cancel: () -> Void
        
        // MARK: - Body
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
        
        // MARK: - Custom Views
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
