//
//  OverridingTheEnvironment.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension OverridingTheEnvironment {
    struct WelcomeView: View {
        var body: some View {
            VStack {
                Image(systemName: "sun.max")
                    .transformEnvironment(\.font) { font in
                        font = font?.weight(.black)
                    }
                
                Text("Welcome!")
            }
        }
    }
}

struct OverridingTheEnvironment: SelfCreatingView {
    var body: some View {
        WelcomeView()
            .font(.largeTitle)
    }
}

struct OverridingTheEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        OverridingTheEnvironment()
    }
}
