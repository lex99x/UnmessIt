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
    
    @Persisted var nickname = ""
    @Persisted var isSpaceOwner = false
    @Persisted var preferences = List<TaskCategory>()
    
}

extension User {
    
    static let mockedUser = User(value: ["nickname": "Alex",
                                         "isSpaceOwner": true] as [String : Any])
    
}

extension User {
    
    func localizedNickname() -> String {
        
        if nickname == "You" || nickname == "Você" {
            return "you".localized
        }
        
        return nickname
        
    }
    
}
