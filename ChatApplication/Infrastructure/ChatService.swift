//
//  ChatService.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation
import Firebase

protocol ChatServiceProtocol {
    func login(username: String) async throws -> CSUser
    func getConversations() async throws -> [CSConversation]
    func listenConversations(onReceived: @escaping (CSConversation) -> Void) throws
    func sendMessage(conversationId: String, message: CSMessage) async throws
    func listenMessage(conversationId: String, onReceived: @escaping ([CSMessage]) -> Void) throws
    func getMessages(conversationId: String) async throws -> [CSMessage]
}

struct ChatService: ChatServiceProtocol {
    
    static let shared: ChatService = ChatService()
    
    let db = Firestore.firestore()
    private var currentUser: CSUser?
    
    func login(username: String) async throws -> CSUser {
        try await db.collection("Users").document(username).setData([:])
        return CSUser(id: username, name: username)
    }
    
    func getConversations() async throws -> [CSConversation] {
        guard let _ = self.currentUser else {
            throw CSError.mustLoginToUse
        }
        // Currently, the app only allow chat between to 2 users, so we assume user list is conversation list
        let snapshot = try await db.collection("Users").getDocuments()
        let conversations = snapshot.documents.map({ CSConversation(id: $0.documentID,
                                                                    name: $0.documentID) })
        return conversations
    }
    
    func listenConversations(onReceived: @escaping (CSConversation) -> Void) throws {
        guard let currentUser = self.currentUser else {
            throw CSError.mustLoginToUse
        }
        db.collection("Users").document(currentUser.id).addSnapshotListener { snapshot, error in
            if let data = snapshot?.data() {
                do {
                    let user = try CSUser(data)
                    let conversation = CSConversation(id: user.id,
                                                      name: user.name)
                    onReceived(conversation)
                } catch {
                    
                }
            }
        }
    }
    
    func sendMessage(conversationId: String, message: CSMessage) async throws {
        guard let currentUser = self.currentUser else {
            throw CSError.mustLoginToUse
        }
        if let data = message.dictionary {
            try await db.collection("Collections")
                .document(currentUser.id)
                .collection(conversationId).document(message.id)
                .setData(data, merge: true)
        }
    }
    
    func listenMessage(conversationId: String, onReceived: @escaping ([CSMessage]) -> Void) throws {
        guard let currentUser = self.currentUser else {
            throw CSError.mustLoginToUse
        }
        db.collection("Collections").document(currentUser.id).collection(conversationId)
            .addSnapshotListener { snapshot, error in
                if let documentChanges = snapshot?.documentChanges {
                    var messages: [CSMessage] = []
                    for document in documentChanges {
                        let data = document.document.data()
                        if let message = convert(data: data) {
                            messages.append(message)
                        }
                    }
                    onReceived(messages)
                }
            }
    }
    
    func getMessages(conversationId: String) async throws -> [CSMessage] {
        guard let currentUser = self.currentUser else {
            throw CSError.mustLoginToUse
        }
        
        let documents = try await db.collection("Collections").document(currentUser.id).collection(conversationId).getDocuments()
        var messages: [CSMessage] = []
        for document in documents.documents {
            let data = document.data()
            let message = convert(data: data)
            if let message = convert(data: data) {
                messages.append(message)
            }
        }
        
        return messages
    }
    
    private func convert(data: [String: Any]) -> CSMessage? {
        var message: CSMessage?
        if let _ = data["text"] {
            do {
                message = try CSTextMessage(data)
            } catch {
                
            }
        } else if let _ = data["image"] {
            do {
                message = try CSImageMessage(data)
            } catch {
                
            }
        }
        return message
    }
}
