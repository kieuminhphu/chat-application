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
        var conversationItems: Set<ConversationItem> = []
        
        private let getConversationUseCase: GetConversationsUserCase
        private let listConversationUseCase: ListenConversationsUseCase
        
        
        init(getConversationUseCase: GetConversationsUserCase,
             listConversationUseCase: ListenConversationsUseCase) {
            
            self.getConversationUseCase = getConversationUseCase
            self.listConversationUseCase = listConversationUseCase
        }
        
        func getConversationList() async {
            let result = await getConversationUseCase.execute()
            switch result {
            case .success(let conversations):
                handleGetConversationSuccess(conversations: conversations)
            case .failure(let error):
                handleGetConversationFailure(error: error)
            }
        }
        
        func listenConversations() {
            let _ = listConversationUseCase.execute { [weak self] conversations in
                guard let strongSelf = self else { return }
                for conversation in conversations {
                    strongSelf.conversationItems.insert(strongSelf.updateConversationItem(conversation: conversation))
                }
            }
        }
        
        private func handleGetConversationSuccess(conversations: [Conversation]) {
            for conversation in conversations {
                conversationItems.insert(updateConversationItem(conversation: conversation))
            }
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
        
        private func updateConversationItem(conversation: Conversation) -> ConversationItem {
                var subtitle = "There are no messages"
                if let textMessage = conversation.lastMessage as? TextMessage {
                    subtitle = textMessage.text
                } else if conversation.lastMessage is ImageMessage {
                    subtitle = "Image message"
                }
                return ConversationItem(id: conversation.id,
                                        title: conversation.name,
                                        subtitle: subtitle,
                                        updatedDate: MessageDateDisplay(date: conversation.lastMessage?.createdDate).display())
            
        }
    }
}
