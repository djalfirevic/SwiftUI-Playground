//
//  SkippingWork2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension SkippingWork2 {
    struct ExampleView: View {
        let number: Int
    
        var body: some View {
            Text("View \(number)")
                .onFirstAppear {
                    print("View \(number) appearing")
                }
        }
    }
}

struct OnFirstAppearModifier: ViewModifier {
    @State private var hasLoaded = false
    var perform: () -> Void

    func body(content: Content) -> some View {
        content.onAppear {
            guard hasLoaded == false else { return }
            hasLoaded = true
            perform()
        }
    }
}

extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}

struct SkippingWork2: SelfCreatingView {
    var body: some View {
        TabView {
            ForEach(1..<6) { i in
                ExampleView(number: i)
                    .tabItem { Label(String(i), systemImage: "\(i).circle") }
            }
        }
    }
}

struct SkippingWork2_Previews: PreviewProvider {
    static var previews: some View {
        SkippingWork2()
    }
}
