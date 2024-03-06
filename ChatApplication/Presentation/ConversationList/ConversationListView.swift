//
//  ConversationListView.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import SwiftUI

struct ConversationListView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.conversationItems, id: \.self) { item in
                    ConversationItemView(conversationItem: item)
                }
            }
            .navigationTitle("Conversations")
        }
        .task {
            await viewModel.getConversationList()
        }
    }
}

#Preview {
    struct PreviewGetConversationsUseCase: GetConversationsUserCase {
        func execute() async -> Result<[Conversation], Error> {
            return .success(Conversation.sampleData)
        }
    }
    
    struct PreviewJoinConversationUseCase: JoinConversationUseCase {
        func execute(conversationId: String) async -> Result<String, Error> {
            return .success(conversationId)
        }
    }
    
    struct PreviewListenMessageUseCase: ListenMessageUseCase {
        func execute(conversationId: String, onReceived: (Message) -> Void) {
            
        }
    }
    
    return ConversationListView(viewModel: ConversationListView.ViewModel(getConversationUseCase: PreviewGetConversationsUseCase(),
                                                                          joinConversationUseCase: PreviewJoinConversationUseCase(),
                                                                          listenMessageUseCase: PreviewListenMessageUseCase()))
}
