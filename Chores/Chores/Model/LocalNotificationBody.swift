//
//  LocalNotificationBody.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 31/07/23.
//

import Foundation

struct LocalNotificationBody {
    
    enum Frequency {
        case none, daily
    }
    
    let title: String
    let subtitle: String
    let timeInterval: TimeInterval
    let repeats: Bool
    let frequency: Frequency
}
