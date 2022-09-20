//
//  AdaptiveLayouts.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct ExampleView: View {
    @State private var counter = 0
    let color: Color

    var body: some View {
        Button {
            counter += 1
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .overlay(
                    Text(String(counter))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                )
        }
        .frame(width: 100, height: 100)
        .rotationEffect(.degrees(.random(in: -20...20)))
    }
}

struct AdaptiveLayouts: SelfCreatingView {
    let layouts = [AnyLayout(VStackLayout()), AnyLayout(HStackLayout()), AnyLayout(ZStackLayout()), AnyLayout(GridLayout())]
    @State private var currentLayout = 0
    
    var layout: AnyLayout {
        layouts[currentLayout]
    }
    
    var body: some View {
        VStack {
            Spacer()

            layout {
                GridRow {
                    ExampleView(color: .red)
                    ExampleView(color: .green)
                }

                GridRow {
                    ExampleView(color: .blue)
                    ExampleView(color: .orange)
                }
            }

            Spacer()

            Button("Change Layout") {
                withAnimation {
                    currentLayout += 1

                    if currentLayout == layouts.count {
                        currentLayout = 0
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}

struct AdaptiveLayouts_Previews: PreviewProvider {
    static var previews: some View {
        AdaptiveLayouts()
    }
}
