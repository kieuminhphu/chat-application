//
//  ChatAuthenticationRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 07/03/2024.
//

import Foundation

struct ChatAuthenticationRepository: AuthenticationRepository {
    
    let chatService: ChatServiceProtocol
    
    func login(username: String) async throws -> User {
        let user = try await chatService.login(username: username)
        return ChatDomainUserMapper.convertFrom(csUser: user)
    }
}
