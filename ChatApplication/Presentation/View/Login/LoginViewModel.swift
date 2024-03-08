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
        private let loginUseCase: LoginUseCase
        
        var willMoveToDetailScreen: Bool = false
        var showError = ShowError()
        
        private var user: User?
        
        init(loginUseCase: LoginUseCase) {
            self.loginUseCase = loginUseCase
        }
        
        func login(userName: String) async {
            let result = await loginUseCase.execute(userName: userName)
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
