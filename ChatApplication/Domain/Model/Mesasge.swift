//
//  MessageStatusEnum.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

enum MessageStatus {
    case unsend
    case sent
    case seen
}

protocol Message {
    var id: String { get set }
    var senderId: String { get set }
    var receiveId: String { get set }
    var status: MessageStatus { get set }
    var createdDate: Date { get set }
}

struct TextMessage: Message {
    var id: String
    var senderId: String
    var receiveId: String
    var status: MessageStatus
    var createdDate: Date
    var text: String
}

struct ImageMessage: Message {
    var id: String
    var senderId: String
    var receiveId: String
    var status: MessageStatus
    var createdDate: Date
    var data: Data
}

