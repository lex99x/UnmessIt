//
//  CreateTaskViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

class NewTaskViewModel: ObservableObject {
    
    @Published var selectedDate = Date.now
    @Published var selectedEndRepeatDate = Date.now
    @Published var selectedOption: String?
    @Published var selectedTimeOption = 1
    @Published var selectedRepetionOption = Time.hours.rawValue
    @Published var selectedAssigneeOption: String?
    @Published var isImportantToggleOn = false
    @Published var isRecurrentToggleOn = false
    @Published var isEndRepeatToggleOn = false
    @Published var whatToDo: String = ""
    @Published var howToDo: String = ""
    
    var assigneeOptions: [String] = ["Fulano", "Ciclano", "Beltrano"]
    
}
