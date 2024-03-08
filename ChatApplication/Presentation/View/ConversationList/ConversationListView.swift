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
                ForEach(Array(viewModel.conversationItems), id: \.self) { item in
                    ConversationItemView(conversationItem: item)
                }
            }
            .navigationTitle("Conversations")
        }
        .task {
            await viewModel.getConversationList()
            viewModel.listenConversations()
        }
    }
}

#Preview {
    struct PreviewGetConversationsUseCase: GetConversationsUserCase {
        func execute() async -> Result<[Conversation], Error> {
            return .success(Conversation.sampleData)
        }
    }
    
    struct PreviewListenConversationsUseCase: ListenConversationsUseCase {
        func execute(onReceived: @escaping ([Conversation]) -> Void) -> Result<Void, Error> {
            return .success(())
        }
    }
    
    return ConversationListView(viewModel: ConversationListView.ViewModel(getConversationUseCase: PreviewGetConversationsUseCase(),
                                                                          listConversationUseCase: PreviewListenConversationsUseCase()))
}
