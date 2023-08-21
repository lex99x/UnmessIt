//
//  RealmHelper.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import RealmSwift
import Foundation

final class RealmHelper {
    static let names = ["Joao", "Agatha", "Maria", "Alex", "Julia", "Fran"]
    static let lastNames = ["Silva", "Costa", "Brenda", "Rocha"]
    
    static func inMemoryRealm() -> Realm {
        var conf = Realm.Configuration.defaultConfiguration
        conf.inMemoryIdentifier = "preview"
        let realm = try! Realm(configuration: conf)
        return realm
    }
    
    static func realmA() -> Realm {
        let realm = inMemoryRealm()
        let group = realm.objects(Space.self).first
        if let group {
            let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking","Pet"]])
            
            for _ in 1...5 {
                try? realm.write {
                    group.residents.append(user)
                }
            }
        } else {
            try? realm.write {
                realm.add(Space())
            }
            
            let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking","Pet"]])
            
            for _ in 1...5 {
                try? realm.write {
                    group?.residents.append(user)
                }
            }
        }
        return realm
    }
    
    
//    static func realmWithItems() -> Realm {
//        let realm = inMemoryRealm()
//
//        let allItems = realm.objects(Item.self)
//
//
//        if allItems.count == 0 {
//            try? realm.write({
//                realm.add(Item())
//                realm.add(Item())
//                realm.add(Item())
//                realm.add(Item())
//                realm.add(Item())
//                realm.add(Item())
//
//            })
//        }
//
//        return realm
//    }
    
//    static func realmMockPreferences() -> Realm {
//        let realm = inMemoryRealm()
//
//        let group = realm.objects(Space.self).first
//
//        let allUsers = realm.objects(User.self)
//
//
//        if allUsers.count == 0 {
//            for _ in 1...4 {
//                try? realm.write({
//                    let user = User()
//
//                    // genrate random nam
//                    user.nickname = "\(String(describing: names.randomElement())) \(String(describing: lastNames.randomElement()))"
//
//                    // Insert preferences
//                    user.preferences.append(User.TaskCategory.allCases.randomElement()!)
//                    user.preferences.append(User.TaskCategory.allCases.randomElement()!)
//                    user.preferences.append(User.TaskCategory.allCases.randomElement()!)
//                    group?.residents.append(user)
//
//                })
//            }
//        }
//
//        return realm
//
//    }
}
