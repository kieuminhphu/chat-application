//
//  ListenMessageUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol ListenMessageUseCase {
    func execute(conversationId: String, onReceived: (Message) -> Void)
}

struct DefaultListenMessageUseCase: ListenMessageUseCase {
    
    let repository: MessageRepository
    
    func execute(conversationId: String, onReceived: ((Message) -> Void)) {
        repository.listenMessage(conversationId: conversationId, onReceived: onReceived)
    }
}
