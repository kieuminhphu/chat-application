//
//  GetConversationsUserCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol GetConversationsUserCase {
    func execute() async -> Result<[Conversation], Error>
}

struct DefaultGetConversationsUserCase: GetConversationsUserCase {
    
    let conversationRepository: ConversationRepository
    let messageRepository: MessageRepository
    
    func execute() async -> Result<[Conversation], Error> {
        do {
            let conversations = try await conversationRepository.getConversations()
            var newConversations: [Conversation] = []
            for conversation in conversations {
                let lastMessage = try await messageRepository.getLastMessage(conversationId: conversation.id)
                var newConversation = Conversation(id: conversation.id, name: conversation.name, lastMessage: lastMessage)
                newConversations.append(conversation)
            }
            return .success(newConversations)
        } catch {
            return .failure(error)
        }
    }
}
