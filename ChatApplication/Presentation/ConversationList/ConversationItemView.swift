//
//  ConversationItemView.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import SwiftUI

struct ConversationItemView: View {
    let conversationItem: ConversationItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(conversationItem.title).font(.headline)
                Spacer()
                Text(conversationItem.updatedDate)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            HStack {
                Text(conversationItem.subtitle)
                    .font(.callout)
                Spacer()
            }
        }
    }
}

#Preview {
    ConversationItemView(conversationItem: ConversationItem.sampleData[0])
}
