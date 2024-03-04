//
//  JoinConversationUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol JoinConversationUseCase {
    func execute(conversationId: String) async -> Result<String, Error>
}

struct DefaultJoinConversationUseCase: JoinConversationUseCase {
    
    let repository: ConversationRepository
    
    func execute(conversationId: String) async -> Result<String, Error> {
        do {
            try await repository.joinConversation(conversationId: conversationId)
            return .success(conversationId)
        } catch {
            return .failure(error)
        }
    }
}
