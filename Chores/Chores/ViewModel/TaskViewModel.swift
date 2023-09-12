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
    @ObservedResults(Task.self, sortDescriptor: SortDescriptor(keyPath: "whenDo", ascending: false)) var tasks
    @ObservedResults(Space.self) var spaces
    
    @Published var isAddingNewTask: Bool = false
    @Published var selectedSpace: Space?
    
    var realm: Realm?
    var token: NotificationToken? = nil
    
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
    
    
    func deleteAll() {
        if let selectedSpace = self.selectedSpace,
           let realm = selectedSpace.realm {
            try? realm.write {
                for item in selectedSpace.tasks {
                    realm.delete(item)
                }
            }
        }
    }
    
    func updateStatus(status: Task.Status, item: Task) {
        if let updatedItem = item.thaw(),
           let realm = updatedItem.realm {
            try! realm.write {
                updatedItem.status = status
            }
        }
        
    }
    
    func registerOwner() {
            let spaceOwner = User()
            spaceOwner.nickname = "You"
            spaceOwner.isSpaceOwner = true
    
            if let thaw = selectedSpace,
               let realm = thaw.realm {
                try? realm.write {
                    thaw.residents.append(spaceOwner)
                    print("added")
                }
            }
    }
    
    func add(){
        var itemList: [Task] = []
        let item1:Task = .init(value: ["title":"U need to do \(Int.random(in: 0...999))", "status": "done", "whenDo":Date(timeIntervalSinceNow: -600000000), "category":"pet"])
        let item2:Task = .init(value: ["title":"U need to do \(Int.random(in: 0...999))", "status": "done", "whenDo":Date(), "category":"pet"])
        let item3:Task = .init(value: ["title":"U need to do \(Int.random(in: 0...999))", "status": "done", "whenDo":Date(timeIntervalSinceNow: +600000000), "category":"pet"])
        
        itemList.append(item1)
        itemList.append(item2)
        itemList.append(item3)
        
        if let selectedSpace = self.selectedSpace,
           let realm = selectedSpace.realm {
            try? realm.write {
                for foo in itemList {
                    selectedSpace.tasks.append(foo)
                }
            }
        }
//        Memo.add(memo)
            

    }
    
//    func filterTasks(filterStr: String) {
//        if let realm = selectedSpaca?.realm {
//            try? realm.wri
//        }
//    }
}
