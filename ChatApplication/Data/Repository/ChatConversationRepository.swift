//
//  ChatConversationRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

struct ChatConversationRepository: ConversationRepository {
  
    let chatService: ChatServiceProtocol
    
    func getConversations() async throws -> [Conversation] {
        let conversations = try await chatService.getConversations()
        return conversations.map({ ChatDomainConversationMapper.convertFrom(csConversation: $0) })
    }
    
    func listenConversation(onReceived: @escaping ([Conversation]) -> Void) throws {
        try chatService.listenConversations { conversations in
            onReceived(conversations.map({ ChatDomainConversationMapper.convertFrom(csConversation: $0) }))
        }
    }
    
}
