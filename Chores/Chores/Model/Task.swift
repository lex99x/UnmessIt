//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import Foundation
import RealmSwift

public enum Types: String, PersistableEnum  {
   case none, clothes, cooking, ligthCleaning, heavyCleanign, grocery, payments, pet, custom
}

final class Task: Object, ObjectKeyIdentifiable {

    
    enum Status: String, PersistableEnum {
        case none, done, pending, cantDo
    }
    
    enum TaskOwner: String, PersistableEnum {
        case resident, rotation
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var isImportant = false
    @Persisted var createdAt = Date()
    
    // MARK: ENUMS
    @Persisted var type: Types = .none
    @Persisted var status: Status = .none
    @Persisted var taskOwner: TaskOwner?

    
    @Persisted var taskParticipants: List<User>
}
    
