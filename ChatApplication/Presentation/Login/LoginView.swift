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

struct PreviewJoinConversationUseCase: JoinConversationUseCase {
    func execute(conversationId: String) async -> Result<String, Error> {
        return .success(conversationId)
    }
}

struct PreviewListenMessageUseCase: ListenMessageUseCase {
    func execute(conversationId: String, onReceived: (Message) -> Void) {
        
    }
}

struct LoginView: View {
    @State var viewModel: ViewModel
    
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                textFieldView(title: "Username", text: $userName)
                secureFieldView(title: "Password", text: $password)
                loginButton
                Spacer()
            }
            .alert(viewModel.showError.error, isPresented: $viewModel.showError.isShowing, actions: {
                Text("OK")
            })
            .padding()
            .background(.secondary.opacity(0.1))
            .navigationBarTitle("Enter to chat", displayMode: .inline)
            .navigationDestination(isPresented: $viewModel.willMoveToDetailScreen) {
                // move to conversation list
                return ConversationListView(viewModel: ConversationListView.ViewModel(getConversationUseCase: PreviewGetConversationsUseCase(),
                                                                                      joinConversationUseCase: PreviewJoinConversationUseCase(),
                                                                                      listenMessageUseCase: PreviewListenMessageUseCase()))
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
    
    private func secureFieldView(title: String, text: Binding<String>) -> some View {
        return VStack(alignment: .leading, spacing: 11) {
            Text(title)
                .font(.system(size: 13, weight: .light))
                .foregroundColor(.secondary)
                .frame(height: 15, alignment: .leading)
            
            SecureField("", text: text)
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
                await viewModel.login(userName: userName, password: password)
            }
        }, label: {
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .frame(width: 215, height: 44, alignment: .center)
        })
        .background((userName.isEmpty && password.isEmpty) ? .secondary : .primary)
        .disabled((userName.isEmpty && password.isEmpty))
        .cornerRadius(4)
        .padding(.top, 36)
    }
}

#Preview {
    
    struct PreviewAuthenticationUseCase: AuthenticationUseCase {
        func execute(userName: String, password: String) async -> Result<User, Error> {
            return .success(User.sampleData)
        }
    }
    return LoginView(viewModel: LoginView.ViewModel(authenticationUseCase: PreviewAuthenticationUseCase()))
}
