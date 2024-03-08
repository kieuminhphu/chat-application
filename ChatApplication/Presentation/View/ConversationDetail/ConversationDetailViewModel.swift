//
//  ConversationDetailViewModel.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import Foundation

extension ConversationDetailView {
    @Observable
    final class ViewModel {
        var showError = ShowError()
        var messageItems: [any MessageItem] = []
        var messages: [Message] = []
        
        private let getMessagesUseCase: GetMessagesUseCase
        private let sendMessageUseCase: SendMessageUseCase
        private let listenMessageUseCase: ListenMessageUseCase
        private let conversationId: String
        
        init(conversationId: String,
            getMessagesUseCase: GetMessagesUseCase,
             sendMessageUseCase: SendMessageUseCase,
             listenMessageUseCase: ListenMessageUseCase) {
            self.getMessagesUseCase = getMessagesUseCase
            self.sendMessageUseCase = sendMessageUseCase
            self.listenMessageUseCase = listenMessageUseCase
            self.conversationId = conversationId
        }
        
        func getMessages() async {
            let result = await getMessagesUseCase.execute(conversationId: conversationId)
            switch result {
            case .success(let messages):
                handleGetMessagesSuccess(messages: messages)
            case .failure(let error):
                handleGetMessageFailure(error: error)
            }
        }
        
        private func handleGetMessagesSuccess(messages: [Message]) {
//            messageItems = messages.map { message in
//                
//            }
        }
        
        private func handleGetMessageFailure(error: Error) {
            var errorString = ""
            if let conversationError = error as? ConversationError, conversationError == ConversationError.getConversationsError {
                errorString = "Get Messages Error. Please try again!"
            } else {
                errorString = error.localizedDescription
            }
            showError = ShowError(isShowing: true,
                                  error: errorString)
        }
        
        private func updateMessageItem(message: Message) -> (any MessageItem)? {
            var direction = ChatBubbleShape.Direction.left
            if let textMessage = message as? TextMessage {
//                if textMessage.senderId ==
//                return TextMessageItem(id: <#T##String#>, direction: <#T##ChatBubbleShape.Direction#>, text: <#T##String#>)
            } else if let imageMessage = message as? ImageMessage {
                
            }
            return nil
        }
    }
}
