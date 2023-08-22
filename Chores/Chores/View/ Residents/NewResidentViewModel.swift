//
//  NewResidentViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 20/08/23.
//

import Foundation
import RealmSwift
import SwiftUI

final class NewResidentViewModel: ObservableObject {
    
    @ObservedResults(Space.self) var spaces
    private var token: NotificationToken? = nil
    
    @Published var residentName: String = ""
    @Published var selections: [String] = []
    
    
    init() {
        token = spaces.observe({ (changes) in
            switch changes {
            case .error(_): break
            case .initial(_): break
            case .update(_, deletions: _, insertions: _, modifications: _):
                self.objectWillChange.send()
            }
        })
    }
    
    func addResident() {
        let user = User()
        user.nickname = residentName
        
        for item in selections {
            user.preferences.append(TaskCategory(rawValue: item)!)
        }
    
        
        if let space = spaces.first,
           let realm = space.realm {
            try? realm.write {
                space.residents.append(user)
            }
        }
    }
    
    func updateUser(item: User) {
        if let thaw = item.thaw(),
           let realm = thaw.realm {
            try? realm.write {
                var preferences = RealmSwift.List<TaskCategory>()
                thaw.nickname = residentName
                
                for item in selections {
                    preferences.append(TaskCategory(rawValue: item)!)
                }
                thaw.preferences = preferences
            }
        }
    }
    
    
}
