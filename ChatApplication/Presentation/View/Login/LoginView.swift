//
//  LoginView.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import SwiftUI

struct PreviewGetConversationsUseCase: GetConversationsUserCase {
    func execute() async -> Result<[Conversation], Error> {
        return .success(Conversation.sampleData)
    }
}

struct PreviewListenMessageUseCase: ListenMessageUseCase {
    func execute(conversationId: String, onReceived: @escaping ([Message]) -> Void) {
     
    }
}

struct LoginView: View {
    @State var viewModel: ViewModel
    
    @State private var username: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                textFieldView(title: "Usename", text: $username)
                loginButton
                Spacer()
            }
            .alert(viewModel.showError.error, isPresented: $viewModel.showError.isShowing, actions: {
                Text("OK")
            })
            .padding()
            .background(.secondary.opacity(0.1))
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationDestination(isPresented: $viewModel.willMoveToDetailScreen) {
                // move to conversation list
                ConversationListView(viewModel: ConversationListView.ViewModel(getConversationUseCase: DefaultGetConversationsUserCase(conversationRepository: ChatConversationRepository(chatService: ChatService.shared),
                                                                                                                                       messageRepository: ChatMessageRepository(chatService: ChatService.shared)),
                                                                               listConversationUseCase: DefaultListenConversationsUseCase(conversationRepository: ChatConversationRepository(chatService: ChatService.shared),
                                                                                                                                                 messageRepository: ChatMessageRepository(chatService: ChatService.shared))))
            }
        }
    }
    
    private func textFieldView(title: String, text: Binding<String>) -> some View {
        return VStack(alignment: .leading, spacing: 11) {
            Text(title)
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.secondary)
                .frame(height: 15, alignment: .leading)
            
            TextField("", text: text)
                .font(.system(size: 17, weight: .thin))
                .foregroundColor(.primary)
                .frame(height: 44)
                .padding(.horizontal, 12)
                .background(Color.white)
                .cornerRadius(4.0)
        }
    }
    
    var loginButton: some View {
        Button(action: {
            Task {
                await viewModel.login(userName: username)
            }
        }, label: {
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .frame(width: 215, height: 44, alignment: .center)
        })
        .background((username.isEmpty) ? .secondary : .primary)
        .disabled((username.isEmpty))
        .cornerRadius(4)
        .padding(.top, 36)
    }
}

#Preview {
    
    struct PreviewLoginUseCase: LoginUseCase {
        func execute(userName: String) async -> Result<User, Error> {
            return .success(User.sampleData)
        }
    }
    return LoginView(viewModel: LoginView.ViewModel(loginUseCase: PreviewLoginUseCase()))
}
