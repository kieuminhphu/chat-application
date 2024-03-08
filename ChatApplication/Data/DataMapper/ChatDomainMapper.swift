//
//  ChatDomainMapper.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

struct ChatDomainUserMapper {
    static func convertFrom(csUser: CSUser) -> User {
        return User(id: csUser.id, name: csUser.name)
    }
    
    static func convertFrom(user: User) -> CSUser {
        return CSUser(id: user.id, name: user.name)
    }
}

struct ChatDomainConversationMapper {
    static func convertFrom(csConversation: CSConversation) -> Conversation {
        return Conversation(id: csConversation.id, name: csConversation.name, lastMessage: nil)
    }
    
    static func convertFrom(conversation: Conversation) -> CSConversation {
        return CSConversation(id: conversation.id, name: conversation.name)
    }
}

struct ChatDomainMessageMapper {
    static func convertFrom(csMessage: CSMessage) -> Message? {
        if let textMessage = csMessage as? CSTextMessage {
            return TextMessage(id: textMessage.id, 
                               senderId: textMessage.senderId,
                               status: ChatDomainMessageStatusMapper.convertFrom(csStatus: textMessage.status),
                               createdDate: Date(timeIntervalSince1970: textMessage.createdDate),
                               text: textMessage.text)
            
        } else if let imageMessage = csMessage as? CSImageMessage {
            return ImageMessage(id: imageMessage.id,
                               senderId: imageMessage.senderId,
                               status: ChatDomainMessageStatusMapper.convertFrom(csStatus: imageMessage.status),
                               createdDate: Date(timeIntervalSince1970: imageMessage.createdDate),
                                data: imageMessage.data)
        }
        return nil
    }
    
    static func convertFrom(message: Message) -> CSMessage? {
        if let textMessage = message as? TextMessage {
            return CSTextMessage(id: textMessage.id,
                               senderId: textMessage.senderId,
                               status: ChatDomainMessageStatusMapper.convertFrom(status: textMessage.status),
                                 createdDate: textMessage.createdDate.timeIntervalSince1970,
                               text: textMessage.text)
            
        } else if let imageMessage = message as? ImageMessage {
            return CSImageMessage(id: imageMessage.id,
                               senderId: imageMessage.senderId,
                               status: ChatDomainMessageStatusMapper.convertFrom(status: imageMessage.status),
                               createdDate: imageMessage.createdDate.timeIntervalSince1970,
                                data: imageMessage.data)
        }
        return nil
    }
}

struct ChatDomainMessageStatusMapper {
    static func convertFrom(csStatus: CSMessageStatus) -> MessageStatus {
        switch csStatus {
        case .seen:
            return MessageStatus.seen
        case .sent:
            return MessageStatus.sent
        case .unsend:
            return MessageStatus.unsend
        }
    }
    
    static func convertFrom(status: MessageStatus) -> CSMessageStatus {
        switch status {
        case .seen:
            return CSMessageStatus.seen
        case .sent:
            return CSMessageStatus.sent
        case .unsend:
            return CSMessageStatus.unsend
        }
    }
}
