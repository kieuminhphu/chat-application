//
//  MessageItem.swift
//  ChatApplication
//
//  Created by Kieu Phu on 08/03/2024.
//

import Foundation

protocol MessageItem: Identifiable, Hashable {
    var id: String { get }
    var direction: ChatBubbleShape.Direction { get }
}

struct TextMessageItem: MessageItem {
    var id: String
    var direction: ChatBubbleShape.Direction
    var text: String
}

struct ImageMessageItem: MessageItem {
    var id: String
    var direction: ChatBubbleShape.Direction
    var image: Data
}
