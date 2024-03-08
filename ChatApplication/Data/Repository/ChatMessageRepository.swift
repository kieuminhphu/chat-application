//
//  ChatMessageRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

struct ChatMessageRepository: MessageRepository {
    
    let chatService: ChatServiceProtocol
    
    func sendMessage(conversationId: String, message: Message) async throws {
        if let csMessage = ChatDomainMessageMapper.convertFrom(message: message) {
            try await chatService.sendMessage(conversationId: conversationId, message: csMessage)
        }
    }
    
    func listenMessage(conversationId: String, onReceived: @escaping ([Message]) -> Void) throws {
        try chatService.listenMessage(conversationId: conversationId) { csMessages in
            let messages = csMessages.compactMap({ ChatDomainMessageMapper.convertFrom(csMessage: $0) })
            onReceived(messages)
        }
    }
    
    func getMessages(conversationId: String) async throws -> [Message] {
        let messages = try await chatService.getMessages(conversationId: conversationId)
        return messages.compactMap({ ChatDomainMessageMapper.convertFrom(csMessage: $0) } )
    }
    
    func getLastMessage(conversationId: String) async throws -> Message? {
        let messages = try await getMessages(conversationId: conversationId)
        return messages.last
    }
    
}
