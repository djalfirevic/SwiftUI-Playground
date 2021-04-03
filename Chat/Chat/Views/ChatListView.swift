//
//  ChatListView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct ChatListView: View {
    
    // MARK: - Properties
    @ObservedObject private var session = SessionStore()
    @ObservedObject private var viewModel = ChatroomsViewModel()
    @State private var joinModal = false
    
    // MARK: - Initializer
    init() {
        viewModel.fetchData()
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List(viewModel.chatrooms) { chatroom in
                NavigationLink(destination: MessagesView(chatroom: chatroom)) {
                    HStack {
                        VStack {
                            Text(chatroom.title)
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle("Chatrooms")
                .navigationBarItems(trailing: Button(action: {
                    self.joinModal = true
                }, label: {
                    Image(systemName: "plus.circle")
                }))
                .sheet(isPresented: $joinModal, content: {
                    JoinView(isOpen: $joinModal)
                })
            }
        }
    }
    
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
