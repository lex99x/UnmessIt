//
//  Home.swift
//  Chores
//
//  Created by Alex A. Rocha on 25/07/23.
//

import Foundation
import RealmSwift

final class Space: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId

    // MARK: Home propeties
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var membersNumber = 0
    @Persisted var terms = ""
    
    // MARK: Task list - one home can have many tasks
    @Persisted var tasks =  RealmSwift.List<Task>()
    @Persisted var residents = RealmSwift.List<User>()
}
