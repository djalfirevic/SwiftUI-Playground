//
//  MessagesViewModel.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import Foundation
import Firebase

final class MessagesViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var messages = [Message]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    // MARK: - Public API
    func sendMessage(messageContent: String, documentId: String) {
        guard user != nil else { return }
        
        db.collection("chatrooms").document(documentId).collection("messages").addDocument(data: [
                                                                                            "sentAt": Date(),
                                                                                            "displayName": user!.email ?? "",
                                                                                            "content": messageContent,
                                                                                            "sender": user!.uid])
    }
    
    func fetchData(documentId: String) {
        guard user != nil else { return }
        
        db.collection("chatrooms").document(documentId).collection("messages").order(by: "sentAt", descending: false).addSnapshotListener({(snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }
            
            self.messages = documents.map { docSnapshot -> Message in
                let data = docSnapshot.data()
                let docId = docSnapshot.documentID
                let content = data["content"] as? String ?? ""
                let displayName = data["displayName"] as? String ?? ""
                return Message(id: docId, content: content, name: displayName)
            }
        })
    }
    
}
