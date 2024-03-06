//
//  MessageDateDisplay.swift
//  ChatApplication
//
//  Created by Kieu Phu on 05/03/2024.
//

import Foundation

struct MessageDateDisplay {
    let date: Date?
    
    func display() -> String {
        guard let validDate = date else { return "" }
        let secondsAgo = Int(Date().timeIntervalSince(validDate))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        }
        
        else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        }
        else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        }
        else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}
