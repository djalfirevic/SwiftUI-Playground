//
//  Book.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

protocol SelfCreatingView: View {
    init()
}

struct Book: Decodable {
    struct Section: Identifiable, Decodable {
        var id: String { title }
        let title: String
        let chapters: [Chapter]
    }

    struct Chapter: Identifiable, Decodable, Hashable {
        var id: String { title }
        let title: String
        let subtitle: String
        
        // We need to load the view for the chapter, and I'm certainly not about
        // to type out a big name:struct dictionary. So, time for some hacks…
        func makeView() -> some View {
            let strippedTitle = title.replacing(/[. ]/, with: "")
            let mangledName = "10ProSwiftUI\(strippedTitle.count)\(strippedTitle)V"
            
            if let view = _typeByName(mangledName) as? any SelfCreatingView.Type {
                return AnyView(view.init())
                        .navigationTitle(title)
            } else {
                fatalError("Failed to instantiate view for \(strippedTitle)")
            }
        }
    }
    
    var sections: [Section]
    
    init() {
        guard let url = Bundle.main.url(forResource: "Contents", withExtension: "json") else {
            fatalError("Unable to locate contents.json in bundle.")
        }
        
        guard let contents = try? Data(NSData(contentsOf: url)) else {
            fatalError("Unable to load contents.json from bundle.")
        }
        
        guard let book = try? JSONDecoder().decode(Self.self, from: contents) else {
            fatalError("Unable to parse contents.json in bundle.")
        }
        
        sections = book.sections
    }
}


