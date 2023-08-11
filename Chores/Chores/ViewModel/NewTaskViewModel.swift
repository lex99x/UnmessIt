//
//  CreateTaskViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

class NewTaskViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var description = ""
    
    @Published var selectedStartDate = Date.now
    @Published var selectedEndRepeatDate = Date.now
    
    @Published var selectedTaskTypeOption = Types.none.rawValue
    @Published var selectedTimeOption = 1
    @Published var selectedRepetionOption = Time.hours.rawValue
    @Published var selectedAssigneeOption = ""
    
    @Published var isImportantToggleOn = false
    @Published var isRecurrentToggleOn = false
    @Published var isEndRepeatToggleOn = false
    
    var assigneeOptions: [String] = ["Fulano", "Ciclano", "Beltrano"]
    
    func addNewTask() {
        
        let task = Task()
        
        guard case task.type = Types(rawValue: selectedTaskTypeOption) else { return }
        task.title = title
        task.desc = description
        task.isImportant = isImportantToggleOn
        
        
    }
    
}
