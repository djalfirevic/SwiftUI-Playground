//
//  SearchBar.swift
//  ToDoList
//
//  Created by Djuro Alfirevic on 5/4/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI
import UIKit

/*struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search..."
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String

    init(_ text: Binding<String>) {
        self._text = text
    }

    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        text = searchText

        print("textDidChange: \(text)")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true

        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}*/

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    private var searchText: Binding<String> {
        Binding<String>(
            get: {
                self.text.capitalized
            }, set: {
                self.text = $0
            }
        )
    }

    var body: some View {
        HStack {
            TextField("Search ...", text: searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
