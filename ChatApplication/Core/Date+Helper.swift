//
//  Date+Helper.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import Foundation

extension Date {
    func toDateString(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
