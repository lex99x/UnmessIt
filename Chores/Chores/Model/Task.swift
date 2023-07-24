//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import Foundation
import SwiftUI
import Combine

struct Task {
    
    enum Types {
        case none, clothes, cooking, ligthCleaning, heavyCleanign, grocery, payments, pet, custom
    }
    
    enum Status {
        case none, done, pending, cantDo
    }
    
    enum TaskOwner {
        case none, resident, rotation
    }
    var type: Types
    var status: Status
    var taskOwner: TaskOwner
    var isImportant: Bool
    var description: String
    var name: String
    var datetime: Date
}

