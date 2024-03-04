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
    
    let repository: ConversationRepository
    
    func execute() async -> Result<[Conversation], Error> {
        do {
            let conversations = try await repository.getConversations()
            return .success(conversations)
        } catch {
            return .failure(error)
        }
    }
}
