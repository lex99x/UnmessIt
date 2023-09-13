//
//  User.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 27/07/23.
//

import Foundation
import RealmSwift

final class User: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var nickname: String = ""
    @Persisted var isSpaceOwner: Bool = false
    @Persisted var preferences = RealmSwift.List<TaskCategory>()
    
}

extension User {
    
    static let mockedUser = User(value: ["nickname": "Alex",
                                         "isSpaceOwner": true] as [String : Any])
    
}
