//
//  LoginUseCase.swift
//  ChatApplication
//
//  Created by Kieu Phu on 04/03/2024.
//

import Foundation

protocol LoginUseCase {
    func execute(userName: String) async -> Result<User, Error>
}

struct DefaultLoginUseCase: LoginUseCase {
    let repository: AuthenticationRepository
    
    func execute(userName: String) async -> Result<User, Error> {
        do {
            let user = try await repository.login(username: userName)
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
}
