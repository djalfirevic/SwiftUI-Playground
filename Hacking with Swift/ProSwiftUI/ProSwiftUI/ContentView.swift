//
//  ContentView.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct ContentView: View {
    let book = Book()

    var body: some View {
        NavigationStack {
            List {
                ForEach(book.sections) { section in
                    Section(section.title) {
                        ForEach(section.chapters) { chapter in
                            NavigationLink(value: chapter) {
                                VStack(alignment: .leading) {
                                    Text(chapter.title)
                                        .font(.headline)
                                    
                                    Text(chapter.subtitle)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Book.Chapter.self) { chapter in
                chapter.makeView()
            }
            .navigationTitle("Pro SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
