//
//  ListenMessageUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol ListenMessageUseCase {
    func execute(conversationId: String, onReceived: @escaping ([Message]) -> Void)
}

struct DefaultListenMessageUseCase: ListenMessageUseCase {
    
    let repository: MessageRepository
    
    func execute(conversationId: String, onReceived: @escaping (([Message]) -> Void)) {
        do {
            try repository.listenMessage(conversationId: conversationId, onReceived: onReceived)
        } catch {
            
        }
    }
}
