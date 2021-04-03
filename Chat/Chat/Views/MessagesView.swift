//
//  MessagesView.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import SwiftUI

struct MessagesView: View {
    
    // MARK: - Properties
    private let chatroom: Chatroom
    @ObservedObject private var viewModel = MessagesViewModel()
    @State private var messageField = ""
    
    // MARK: - Initializer
    init(chatroom: Chatroom) {
        self.chatroom = chatroom
        viewModel.fetchData(documentId: chatroom.id)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                HStack {
                    Text(message.content)
                    Spacer()
                }
            }
            HStack {
                TextField("Enter message...", text: $messageField)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    viewModel.sendMessage(messageContent: messageField, documentId: chatroom.id)
                }, label: {
                    Text("Send")
                })
            }
        }
        .navigationBarTitle(chatroom.title)
    }
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(chatroom: Chatroom(id: "10101", title: "Hello!", joinCode: 10))
    }
}
