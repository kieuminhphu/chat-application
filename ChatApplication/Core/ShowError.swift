//
//  ShowError.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import Foundation

struct ShowError {
    var isShowing: Bool
    var error: String
    
    init(isShowing: Bool = false, error: String = "") {
        self.isShowing = isShowing
        self.error = error
    }
}
