//
//  UpdateConversationDateUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol UpdateConversationDateUseCase {
    func execute(conversationId: String) async -> Result<String, Error>
}

struct DefaultUpdateConversationDateUseCase: UpdateConversationDateUseCase {
    let repository: ConversationRepository
    
    func execute(conversationId: String) async -> Result<String, Error> {
        do {
            try await repository.updateConversationDate(conversationId: conversationId)
            return .success(conversationId)
        } catch {
            return .failure(error)
        }
    }
}
