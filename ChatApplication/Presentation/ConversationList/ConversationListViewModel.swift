//
//  ConversationListViewModel.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

extension ConversationListView {
    @Observable
    final class ViewModel {
        
        var showError = ShowError()
        var conversationItems: [ConversationItem] = []
        
        let getConversationUseCase: GetConversationsUserCase
        let joinConversationUseCase: JoinConversationUseCase
        let listenMessageUseCase: ListenMessageUseCase
        
        init(getConversationUseCase: GetConversationsUserCase,
             joinConversationUseCase: JoinConversationUseCase,
             listenMessageUseCase: ListenMessageUseCase) {
            
            self.getConversationUseCase = getConversationUseCase
            self.joinConversationUseCase = joinConversationUseCase
            self.listenMessageUseCase = listenMessageUseCase
        }
        
        func getConversationList() async {
            let result = await getConversationUseCase.execute()
            switch result {
            case .success(let conversations):
                print(conversations)
                handleGetConversationSuccess(conversations: conversations)
            case .failure(let error):
                handleGetConversationFailure(error: error)
            }
        }
        
        private func handleGetConversationSuccess(conversations: [Conversation]) {
            conversationItems = conversations.map({ conversation in
                var subtitle = ""
                if let textMessage = conversation.lastMessage as? TextMessage {
                    subtitle = textMessage.text
                } else if conversation.lastMessage is ImageMessage {
                    subtitle = "Image message"
                }
                return ConversationItem(id: conversation.id,
                                        title: conversation.name,
                                        subtitle: subtitle,
                                        updatedDate: MessageDateDisplay(date: conversation.lastMessage?.createdDate).display())
            })
        }
        
        private func handleGetConversationFailure(error: Error) {
            var errorString = ""
            if let conversationError = error as? ConversationError, conversationError == ConversationError.getConversationsError {
                errorString = "Get Conversations Error. Please try again!"
            } else {
                errorString = error.localizedDescription
            }
            showError = ShowError(isShowing: true,
                                  error: errorString)
        }
    }
}
