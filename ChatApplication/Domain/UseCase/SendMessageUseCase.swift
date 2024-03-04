//
//  SendMessageUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol SendMessageUseCase {
    func execute(conversationId: String, message: Message) async -> Result<Message, Error>
}

struct DefaultSendMessageUseCase: SendMessageUseCase {
    
    let repository: MessageRepository
    
    func execute(conversationId: String, message: Message) async -> Result<Message, Error> {
        do {
            var message = try await repository.sendMessage(conversationId: conversationId, message: message)
            message.status = MessageStatus.sent
            return .success(message)
        } catch {
            return .failure(error)
        }
    }
}
