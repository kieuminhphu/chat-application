//
//  ConversationRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import Foundation

protocol ConversationRepository {
    func getConversations() async throws -> [Conversation]
    func listenConversation(onReceived: @escaping ([Conversation]) -> Void) throws
}
