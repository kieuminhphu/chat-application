//
//  ListenConversationUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

protocol ListenConversationsUserCase {
    func execute() async -> Result<[Conversation], Error>
}

struct DefaultListenConversationsUserCase: ListenConversationsUserCase {
    
    let conversationRepository: ConversationRepository
    let messageRepository: MessageRepository
    
    func execute() async -> Result<[Conversation], Error> {
        do {
            let conversations = try await conversationRepository.getConversations()
            var newConversations: [Conversation] = []
            for conversation in conversations {
                let lastMessage = try await messageRepository.getLastMessage(conversationId: conversation.id)
                let newConversation = Conversation(id: conversation.id, name: conversation.name, lastMessage: lastMessage)
                newConversations.append(newConversation)
            }
            return .success(newConversations)
        } catch {
            return .failure(error)
        }
    }
}
