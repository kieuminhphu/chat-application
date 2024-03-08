//
//  Conversation.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let lastMessage: Message?
}

extension Conversation {
    static let sampleData = [Conversation(id: "1",
                                          name: "Phu",
                                          lastMessage: TextMessage(id: "1",
                                                                   senderId: "1",
                                                                   status: MessageStatus.seen,
                                                                   createdDate: Date(timeIntervalSince1970: 1709520176),
                                                                   text: "Hello! How are you")),
                             Conversation(id: "2",
                                          name: "Kieu",
                                          lastMessage: TextMessage(id: "2",
                                                                   senderId: "1",
                                                                   status: MessageStatus.seen,
                                                                   createdDate: Date(timeIntervalSince1970: 1707014576),
                                                                   text: "What are you looking for in the company fwef awe fawe fawef awef awef")),
                             Conversation(id: "3",
                                          name: "Minh",
                                          lastMessage: TextMessage(id: "3",
                                                                   senderId: "1",
                                                                   status: MessageStatus.sent,
                                                                   createdDate: Date(timeIntervalSince1970: 1708742576),
                                                                   text: "How much?"))]
}
