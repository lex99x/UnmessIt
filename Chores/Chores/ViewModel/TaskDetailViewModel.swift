//
//  TaskDetailViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 23/08/23.
//

import Foundation
import SwiftUI
import RealmSwift

final class TaskDetailViewModel: ObservableObject {
    
    @ObservedResults(Space.self) var spaces
    @Published var selectedSpace: Space?
    @Published var isAddingNewTask = false
    @Published var didDeleteTask = false
    var realm: Realm?
    var token: NotificationToken? = nil
    
    init() {
        
        let realm = try? Realm()
        self.realm = realm
        
        if let space = realm?.objects(Space.self).first {
            self.selectedSpace = space
        }
    }
    
    func deleteTask(item: Task) {
        if let thaw = item.thaw(),
           let realm = thaw.realm {
            try? realm.write {
                realm.delete(thaw)
            }
        }
//        print(selectedSpace?.tasks)
    }
    
    func updateStatus(item: Task, status: Task.Status) {
        if let thaw = item.thaw(),
           let realm = thaw.realm {
            try? realm.write {
                thaw.status = status
            }
        }
    }
    
    func sayHi() {
        print("hello")
    }
}
