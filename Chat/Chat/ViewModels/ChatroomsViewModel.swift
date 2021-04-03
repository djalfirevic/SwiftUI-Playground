//
//  ChatroomsViewModel.swift
//  Chat
//
//  Created by Djuro on 4/3/21.
//

import Foundation
import Firebase

final class ChatroomsViewModel: ObservableObject {

    // MARK: - Properties
    @Published var chatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    // MARK: - Public API
    func fetchData() {
        guard user != nil else { return }
        
        db.collection("chatrooms").whereField("users", arrayContains: user!.uid).addSnapshotListener({ (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            self.chatrooms = documents.map({ docSnapshot -> Chatroom in
                let data = docSnapshot.data()
                let docId = docSnapshot.documentID
                let title = data["title"] as? String ?? ""
                let joinCode = data["joinCode"] as? Int ?? -1
                return Chatroom(id: docId, title: title, joinCode: joinCode)
            })
            
            print("Number of chatrooms", self.chatrooms.count)
        })
    }
    
    func createChatroom(title: String, handler: @escaping () -> Void) {
        guard user != nil else { return }
        
        db.collection("chatrooms").addDocument(data: [
                                                "title": title,
                                                "joinCode": Int.random(in: 10000..<99999),
                                                "users": [user!.uid]]) { error in
            if let error = error {
                print("Error adding document", error)
            } else {
                handler()
            }
        }
    }
    
    func joinChatroom(code: String, handler: @escaping () -> Void) {
        guard user != nil else { return }
        
        db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(code) ?? 0).getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error getting documents:", error)
            } else {
                for document in snapshot!.documents {
                    self.db.collection("chatrooms").document(document.documentID).updateData(
                        ["users": FieldValue.arrayUnion([self.user!.uid])]
                    )
                    
                    handler()
                }
            }
        }
    }
    
}
