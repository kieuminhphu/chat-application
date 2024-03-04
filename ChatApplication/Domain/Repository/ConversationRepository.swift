//
//  ConversationRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import Foundation

protocol ConversationRepository {
    func getConversations() async throws -> [Conversation]
    func joinConversation(conversationId: String) async throws
    func updateConversationDate(conversationId: String) async throws
}
