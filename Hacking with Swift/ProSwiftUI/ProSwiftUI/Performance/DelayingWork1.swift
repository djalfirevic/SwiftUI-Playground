//
//  DelayingWork1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import Combine
import SwiftUI

extension DelayingWork1 {
    class Debouncer<T>: ObservableObject {
        @Published var input: T
        @Published var output: T
    
        private var textDebounce: AnyCancellable?
        
        init(initialValue: T, delay: Double = 1) {
            self.input = initialValue
            self.output = initialValue

            textDebounce = $input
                .debounce(for: .seconds(delay), scheduler: DispatchQueue.main)
                .sink { [weak self] in
                    self?.output = $0
                }
        }
    }
}

struct DelayingWork1: SelfCreatingView {
    @StateObject private var text = Debouncer(initialValue: "", delay: 0.5)
    @StateObject private var slider = Debouncer(initialValue: 0.0, delay: 0.1)

    var body: some View {
        VStack {
            TextField("Search for something", text: $text.input)
                .textFieldStyle(.roundedBorder)
            Text(text.output)

            Spacer().frame(height: 50)

            Slider(value: $slider.input, in: 0...100)
            Text(slider.output.formatted())
        }
    }

}

struct DelayingWork1_Previews: PreviewProvider {
    static var previews: some View {
        DelayingWork1()
    }
}
