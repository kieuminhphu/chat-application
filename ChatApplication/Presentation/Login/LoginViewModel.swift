//
//  LoginViewModel.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

extension LoginView {
    
    struct ShowError {
        var isShowing: Bool
        var error: String
        
        init(isShowing: Bool = false, error: String = "") {
            self.isShowing = isShowing
            self.error = error
        }
    }
    
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
                self.user = user
                willMoveToDetailScreen = true
            case .failure(let error):
                var errorString: String = ""
                if let loginError = error as? LoginError, loginError == LoginError.cannotLogin {
                    errorString = "Username or password incorrect"
                } else {
                    errorString = error.localizedDescription
                }
                showError = ShowError(isShowing: true, error: errorString)
            }
        }
        
        func dismissError() {
            showError = ShowError()
        }
    }
}
