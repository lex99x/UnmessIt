//
//  User.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 27/07/23.
//

import Foundation
import RealmSwift

final class User: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var nickname = ""
    @Persisted var profilePhotoPath = ""
    @Persisted var email = ""
    
    @Persisted var preferences: List<Types>
    @Persisted var places = RealmSwift.List<Home>()
    
}
