//
//  TaskViewModel.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 08/08/23.
//



import RealmSwift
import Combine
import Foundation



final class TaskViewModel: ObservableObject {
    
    @Published var tasks = List<Task>()
    
    @Published var selectedSpaca: Space?
    
    @Published var filteredTasks = List<Task>()
    
    @Published var isAddingNewTask = false
    
    var realm: Realm?
    
    
    var token: NotificationToken? = nil
    
    init() {
        let realm = try? Realm()
        self.realm = realm
        
        if let space = realm?.objects(Space.self).first {
            self.selectedSpaca = space
            self.tasks = space.tasks
        } else {
            try? realm?.write({
                let space = Space()
                realm?.add(space)
                
                // testing tasks
                space.tasks.append(Task())
                space.tasks.append(Task())
                space.tasks.append(Task())
            })
        }
        
        
        
//        token = selectedSpaca?.observe({ [unowned self] (changes) in
//            switch changes {
//            case .error(_): break
//            case .change(_, _): self.objectWillChange.send()
//            case .deleted: self.selectedSpaca = nil
//            }
//
//
//        })
        
        token = selectedSpaca?.tasks.observe({ (changes) in
            switch changes {
            case .error(_): break
            case .initial(_): break
            case .update(_, deletions:_, insertions:_, modifications: _): self.objectWillChange.send()
            }
        })
    }
    
    
    func addNewTask() {
        if let realm = selectedSpaca?.realm {
            try? realm.write {
                selectedSpaca?.tasks.append(Task())
            }
        }
    }
    
    
    
    func delete(at indexSet: IndexSet) {
        if let index = indexSet.first,
           let realm = tasks[index].realm {
            
            try? realm.write({
                realm.delete(tasks[index])
            })
        }
    }
    
//    func filterTasks(filterStr: String) {
//        if let realm = selectedSpaca?.realm {
//            try? realm.wri
//        }
//    }
}
