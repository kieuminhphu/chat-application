//
//  MessageRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol MessageRepository {
    func sendMessage(conversationId: String, message: Message) async throws
    func listenMessage(conversationId: String, onReceived: @escaping ([Message]) -> Void) throws
    func getMessages(conversationId: String) async throws -> [Message]
    func getLastMessage(conversationId: String) async throws -> Message?
}
