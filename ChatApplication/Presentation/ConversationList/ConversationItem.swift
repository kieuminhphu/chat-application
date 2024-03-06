//
//  ConversationItem.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import Foundation

struct ConversationItem: Identifiable, Hashable {
    let id: String
    let title: String
    let subtitle: String
    let updatedDate: String
}

extension ConversationItem {
    static let sampleData = [ConversationItem(id: "1", title: "Phu", subtitle: "Hello! How are you", updatedDate: "2 days ago"),
                             ConversationItem(id: "2", title: "Kieu", subtitle: "What are you looking for in the company", updatedDate: "5 hours ago"),
                             ConversationItem(id: "3", title: "Minh", subtitle: "How much?", updatedDate: "34 minutes ago")]
}
