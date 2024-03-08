//
//  AuthenticationRepository.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import Foundation
protocol AuthenticationRepository {
    func login(username: String) async throws -> User
}
