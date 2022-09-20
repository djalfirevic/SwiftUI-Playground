//
//  TheEnvironment.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct FormElementIsRequiredKey: EnvironmentKey {
    static var defaultValue = false
}

extension EnvironmentValues {
    var required: Bool {
        get { self[FormElementIsRequiredKey.self] }
        set { self[FormElementIsRequiredKey.self] = newValue }
    }
}

extension View {
    func required(_ makeRequired: Bool = true) -> some View {
        environment(\.required, makeRequired)
    }
}

extension TheEnvironment1 {
    struct RequirableTextField: View {
        @Environment(\.required) var required
        
        let title: String
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField(title, text: $text)
                
                if required {
                    Image(systemName: "asterisk")
                        .imageScale(.small)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct TheEnvironment1: SelfCreatingView {
    @State private var firstName = ""
    @State private var lastName = ""

    @State private var makeRequired = false

    var body: some View {
        Form {
            RequirableTextField(title: "First name", text: $firstName)
            RequirableTextField(title: "Last name", text: $lastName)
            Toggle("Make required", isOn: $makeRequired.animation())
        }
        .required(makeRequired)
    }
}


struct TheEnvironment1_Previews: PreviewProvider {
    static var previews: some View {
        TheEnvironment1()
    }
}
