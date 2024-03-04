//
//  GetMessagesUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol GetMessagesUseCase {
    func execute(conversationId: String) async -> Result<[Message], Error>
}

struct DefaultGetMessagesUseCase: GetMessagesUseCase {
    
    let repository: MessageRepository
    
    func execute(conversationId: String) async -> Result<[Message], Error> {
        do {
            let messages = try await repository.getMessages(conversationId: conversationId)
            return .success(messages)
        } catch {
            return .failure(error)
        }
    }
}
