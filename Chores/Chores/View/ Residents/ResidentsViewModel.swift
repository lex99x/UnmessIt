//
//  ResidentsViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import Foundation
import RealmSwift
import SwiftUI

final class ResidentsViewModel: ObservableObject {
        @ObservedResults(User.self) var residents
        @ObservedResults(Space.self) var spaces
    

        private var token: NotificationToken? = nil
        
        
        var realm: Realm?
        var selectedSpace: Space?
        
        init() {
            let realm = try? Realm()
            self.realm = realm
            
            if let space = realm?.objects(Space.self).first {
                self.selectedSpace = space
            }
            
            
            token = spaces.observe({ (changes) in
                switch changes {
                case .error(_): break
                case .initial(_): break
                case .update(_, deletions: _, insertions: _, modifications: _):
                    self.objectWillChange.send()
                }
            })
            }
    
    
    
    func add(){
        let user = User()
        user.nickname = "nome de teste"
        user.preferences.append(.clothes)
        user.preferences.append(.cooking)
        user.preferences.append(.payments
        )
        if let selectedSpace = self.selectedSpace,
           let realm = selectedSpace.realm {
            try? realm.write {
                selectedSpace.residents.append(user)
            }
        }
//        Memo.add(memo)
    }
    func deleteItem(item: User) {
        if let updatedItem = item.thaw(),
           let realm = updatedItem.realm {
            print(updatedItem)
            try! realm.write {
                realm.delete(updatedItem)
            }
        }
    }
//
//    func delete(item: User) {
//        if let foo = item.thaw(),
//           let realm = foo.realm {
//
//            if let index = selectedSpace?.residents.firstIndex(of: foo) {
//                try? realm.write {
//                    selectedSpace?.residents.remove(at: index)
//                    realm.delete(foo)
//                }
//            }
//        }
//    }
//
//    func deleteIndex(at indexSet: IndexSet) {
//        print(indexSet)
//        if let index = indexSet.first,
//           let realm = selectedSpace?.residents[index].realm {
//
//            try? realm.write({
//                realm.delete((selectedSpace?.residents[index])!)
//            })
//        }
//    }

}
