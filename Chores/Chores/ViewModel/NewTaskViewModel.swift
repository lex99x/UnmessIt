//
//  CreateTaskViewModel.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

enum Repetition: String {
    case never = "Never", everyHour = "Every hour", everyday = "Every day", everyWeekday = "Every weekday",
         everyWeekend = "Every weekend", everyWeek = "Every week", everyMonth = "Every month", everyYear = "Every year"
}

class NewTaskViewModel: ObservableObject {
    
    let taskOptions: [String] = [Types.none.rawValue, Types.clothes.rawValue, Types.cooking.rawValue,
                                 Types.ligthCleaning.rawValue, Types.heavyCleaning.rawValue, Types.groceries.rawValue,
                                 Types.payments.rawValue, Types.pet.rawValue, Types.custom.rawValue]
    
    let repetionOptions: [String] = [Repetition.never.rawValue, Repetition.everyHour.rawValue, Repetition.everyday.rawValue,
                                     Repetition.everyWeekday.rawValue, Repetition.everyWeekend.rawValue, Repetition.everyWeek.rawValue,
                                     Repetition.everyMonth.rawValue, Repetition.everyYear.rawValue]
    
    let assigneeOptions: [String] = []
    
    
    @Published var selectedDate = Date.now
    @Published var selectedOption: String?
    @Published var selectedRepetionOption: String?
    @Published var selectedAssigneeOption: String?
    @Published var isImportantToggleOn = false
    @Published var whatToDo: String = ""
    @Published var howToDo: String = ""
    
}
