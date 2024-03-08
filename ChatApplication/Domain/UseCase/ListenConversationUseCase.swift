//
//  ListenConversationUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

protocol ListenConversationsUseCase {
    func execute(onReceived: @escaping ([Conversation]) -> Void) -> Result<Void, Error>
}

struct DefaultListenConversationsUseCase: ListenConversationsUseCase {
    
    let conversationRepository: ConversationRepository
    let messageRepository: MessageRepository
    
    func execute(onReceived: @escaping ([Conversation]) -> Void) -> Result<Void, Error>{
        do {
            try conversationRepository.listenConversation { conversations in
                Task {
                    try await self.handleConversationReceived(conversations: conversations, onReceived: onReceived)
                }
            }
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    private func handleConversationReceived(conversations: [Conversation], onReceived: @escaping ([Conversation]) -> Void) async throws {
        var newConversations: [Conversation] = []
        for conversation in conversations {
            let lastMessage = try await messageRepository.getLastMessage(conversationId: conversation.id)
            let newConversation = Conversation(id: conversation.id, name: conversation.name, lastMessage: lastMessage)
            newConversations.append(newConversation)
        }
        onReceived(newConversations)
    }
}
