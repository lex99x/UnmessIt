//
//  CreateTaskViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI
import RealmSwift
class NewTaskViewModel: ObservableObject {
    @ObservedResults(Space.self) var spaces
    @Published var selectedSpace: Space?
    
    private let validator = CreateTaskValidator()
    
    var realm: Realm?
    var token: NotificationToken? = nil
    
    @Published var titleTextfield = ""
    @Published var descriptionTextfield = ""
    
    @Published var selectedDate = Date()
    
    @Published var selectedTaskTypeOption = ""
    @Published var selectedTimeOption = 1
    
    
    @Published var selectedAssigneeOption: User = User()
    
    @Published var isImportantToggleOn = false
    
    @Published var hasError: Bool = false
    
    
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
    
    
    func addNewTask() {
        let task = Task()
        print("aqui1")
        print(selectedTaskTypeOption)
        
        task.category = TaskCategory(rawValue: selectedTaskTypeOption) ?? .none
        task.title = titleTextfield
        task.desc = descriptionTextfield
        task.assignees.append(selectedAssigneeOption)
        task.whenDo = selectedDate
        
        do {
            try validator.validate(task)
            print("aqiu2")
            if let selectedSpace = self.selectedSpace,
               let realm = selectedSpace.realm {
                try? realm.write {
                    
                    selectedSpace.tasks.append(task)
                    
                }
            }
        } catch {
            self.hasError = true
        }
        
    }
    
    func deleteTask(item: Task) {
        if let thaw = item.thaw(),
           let realm = thaw.realm {
            try? realm.write {
                realm.delete(thaw)
            }
        }
    }
    
    func updateTask(item: Task) {
        if let thaw = item.thaw(),
           let realm = thaw.realm {
            try? realm.write {
                thaw.category = TaskCategory(rawValue: selectedTaskTypeOption) ?? .none
                thaw.title = titleTextfield
                thaw.desc = descriptionTextfield
                thaw.whenDo = selectedDate
                
                if !selectedAssigneeOption.nickname.isEmpty {
                    thaw.assignees.removeAll()
                    thaw.assignees.append(selectedAssigneeOption)
                    
                }
            }
        }
    }
    
    func recommendAssigneer(item: String) -> User? {
        guard let category = TaskCategory(rawValue: item) else { return nil}
        let recommendation = selectedSpace?.residents.where {
            $0.preferences.contains(category)
        }
        
        return recommendation?.randomElement()
    }
}
