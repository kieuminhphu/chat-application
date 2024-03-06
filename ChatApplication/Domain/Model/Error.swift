//
//  Error.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

enum LoginError: Error {
    case cannotLogin
}

enum ConversationError: Error {
    case getConversationsError
}
