//
//  LoginViewModel.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

extension LoginView {
    
    @Observable
    final class ViewModel {
        let authenticationUseCase: AuthenticationUseCase
        
        var willMoveToDetailScreen: Bool = false
        var showError = ShowError()
        
        private var user: User?
        
        init(authenticationUseCase: AuthenticationUseCase) {
            self.authenticationUseCase = authenticationUseCase
        }
        
        func login(userName: String, password: String) async {
            let result = await authenticationUseCase.execute(userName: userName, password: password)
            switch result {
            case .success(let user):
                handleLoginSuccess(user: user)
            case .failure(let error):
                handleLoginFailed(error: error)
            }
        }
        
        func dismissError() {
            showError = ShowError()
        }
        
        private func handleLoginSuccess(user: User) {
            self.user = user
            willMoveToDetailScreen = true
        }
        
        private func handleLoginFailed(error: Error) {
            var errorString: String = ""
            if let loginError = error as? LoginError, loginError == LoginError.cannotLogin {
                errorString = "Username or password incorrect"
            } else {
                errorString = error.localizedDescription
            }
            showError = ShowError(isShowing: true, error: errorString)
        }
    }
}
