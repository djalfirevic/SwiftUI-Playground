//
//  SearchInput.swift
//  Instagram-app
//
//  Created by Willie Yam on 2022-01-13.
//

import SwiftUI

struct SearchInput: View {
    @State var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search", text: $text)
        }
        .frame(width: .infinity)
        .padding(10)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.8980392156862745, green: 0.8980392156862745, blue: 0.8980392156862745)/*@END_MENU_TOKEN@*/)
        .cornerRadius(10)
    }
}

struct SearchInput_Previews: PreviewProvider {
    static var previews: some View {
        SearchInput(text: "")
    }
}
