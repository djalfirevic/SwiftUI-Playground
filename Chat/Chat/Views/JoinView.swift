//
//  JoinView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct JoinView: View {
    
    // MARK: - Properties
    @Binding var isOpen: Bool
    @State private var joinCode = ""
    @State private var newTitle = ""
    @ObservedObject private var viewModel = ChatroomsViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Join a chatroom")
                        .font(.title)
                    TextField("Enter your join code", text: $joinCode)
                    Button(action: {
                        viewModel.joinChatroom(code: joinCode, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Join")
                    })
                }
                .padding(.bottom)
                
                VStack {
                    Text("Create a chatroom")
                        .font(.title)
                    TextField("Enter a new title", text: $newTitle)
                    Button(action: {
                        viewModel.createChatroom(title: newTitle, handler: {
                            self.isOpen = false
                        })
                    }, label: {
                        Text("Create")
                    })
                }
                .padding(.top)
            }
                .navigationBarTitle("Join or create")
        }
    }
    
}

struct JoinView_Previews: PreviewProvider {
    static var previews: some View {
        JoinView(isOpen: .constant(true))
    }
}
