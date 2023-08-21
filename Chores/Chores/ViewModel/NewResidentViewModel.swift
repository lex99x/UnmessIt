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
    
    @Published var residentName: String = ""
    @Published var selections: [String] = []
    
    
    
    
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
    
    
}
