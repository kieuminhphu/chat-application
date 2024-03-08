//
//  CSMessage.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

enum CSMessageStatus: Codable {
    case unsend
    case sent
    case seen
}

protocol CSMessage: Codable {
    var id: String { get set }
    var senderId: String { get set }
    var status: CSMessageStatus { get set }
    var createdDate: Double { get set }
}

struct CSTextMessage: CSMessage {
    var id: String
    var senderId: String
    var status: CSMessageStatus
    var createdDate: Double
    var text: String
}

struct CSImageMessage: CSMessage {
    var id: String
    var senderId: String
    var status: CSMessageStatus
    var createdDate: Double
    var data: Data
}
