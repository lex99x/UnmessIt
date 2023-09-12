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
    @Published var hasError: Bool = false
    @Published var selectedSpace: Space?
    
    private let validator = CreateResidentValidator()
    
    init() {
        self.selectedSpace = spaces.first
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
    
        do {
            try validator.validate(user)
            
            if let space = spaces.first,
               let realm = space.realm {
                try? realm.write {
                    space.residents.append(user)
                }
            }
        } catch {
            self.hasError = true
        }
        
        
    }
    
    func deleteResident(item: User) {
        if let updatedItem = item.thaw(),
           let realm = updatedItem.realm {
            print(updatedItem)
            try! realm.write {
                realm.delete(updatedItem)
            }
        }
    }
    
    func updateUser(item: User) {
        
            if let thaw = item.thaw(),
               let realm = thaw.realm {
                
                try? realm.write {
                    var preferences = RealmSwift.List<TaskCategory>()
                    do {
                        try validator.validateString(residentName)
//                        try validator.validateExistentResident(selectedSpace?.residents as? [User] ?? [], nickname: residentName)
////                        print(selectedSpace?.residents.map{$0.nickname})
//                        let a = selectedSpace?.residents.map{$0.nickname}
                        thaw.nickname = residentName
                    for item in selections {
                        preferences.append(TaskCategory(rawValue: item)!)
                    }
                        thaw.preferences.removeAll()
                        thaw.preferences = preferences
                }
                    catch {
                        self.hasError = true
                    }
                    
                }
            }
            

    }
    
    
}
