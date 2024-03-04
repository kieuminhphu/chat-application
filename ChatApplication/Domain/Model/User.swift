//
//  User.swift
//  ChatApplication
//
//  Created by Kieu Phu on 02/03/2024.
//

import Foundation

struct User {
    let id: String
    let name: String
}

extension User {
    static let sampleData = User(id: "1", name: "Phu")
}
