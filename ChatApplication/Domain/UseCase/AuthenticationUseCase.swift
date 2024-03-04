//
//  AuthenticationUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol AuthenticationUseCase {
    func execute(userName: String, password: String) async -> Result<User, Error>
}

struct DefaultAuthenticationUseCase: AuthenticationUseCase {
    let repository: AuthenticationRepository
    
    func execute(userName: String, password: String) async -> Result<User, Error> {
        do {
            let user = try await repository.login(userName: userName, password: password)
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
}
