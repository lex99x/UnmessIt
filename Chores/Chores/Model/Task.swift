//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI
import RealmSwift

enum TaskCategory: String, PersistableEnum {
    case none = "None", clothes = "Clothes", cooking = "Cooking", ligthCleaning = "Light cleaning",
         heavyCleaning = "Heavy cleaning", groceries = "Groceries", payments = "Payments", pet = "Pet", custom = "Custom"
    
    static let values: [TaskCategory] = [.clothes, .cooking, .ligthCleaning, .heavyCleaning, .groceries, .payments, .pet, .custom]
}

enum TimePeriod: String, PersistableEnum {
    case hours = "Hours", days = "Days", weeks = "Weeks", months = "Months", years = "Years"
}

class Task: Object, ObjectKeyIdentifiable {
    
    static let taskOptions: [String] = [TaskCategory.clothes.rawValue,
                                        TaskCategory.cooking.rawValue,
                                        TaskCategory.ligthCleaning.rawValue,
                                        TaskCategory.heavyCleaning.rawValue,
                                        TaskCategory.groceries.rawValue,
                                        TaskCategory.payments.rawValue,
                                        TaskCategory.pet.rawValue]
    
    static let timePeriodOptions: [String] = [TimePeriod.hours.rawValue,
                                              TimePeriod.days.rawValue,
                                              TimePeriod.weeks.rawValue,
                                              TimePeriod.months.rawValue,
                                              TimePeriod.years.rawValue]
    
    enum Status: String, PersistableEnum {
        case done, pending, cantDo
    }
    
    enum TaskOwner: String, PersistableEnum {
        case resident, rotation
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var createdAt = Date.now
    
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var isImportant = false
    
    @Persisted var startDate: Date
    @Persisted var repetitionNumber: Int
    @Persisted var repetitionTimePeriod: TimePeriod
    @Persisted var endRepeatDate: Date?
    
    // MARK: Enums
    @Persisted var category: TaskCategory
    @Persisted var status: Status = .pending
    @Persisted var owner: TaskOwner?
    
    @Persisted var assignees = RealmSwift.List<User>()
    
    static func getTaskIconByCategory(taskCategory: TaskCategory) -> Image {
        
        switch taskCategory {
            case .clothes:
                return .clothesIcon
            case .cooking:
                return .cookingIcon
            case .ligthCleaning:
                return .lightCleaningIcon
            case .heavyCleaning:
                return .heavyCleaningIcon
            case .groceries:
                return .groceriesIcon
            case .payments:
                return .paymentsIcon
            case .pet:
                return .petsIcon
        }
        
    }
    
    func updateStatus(status: Status){
        if let realm = self.realm {
            try? realm.write({
                self.status = status
            })
        }
    }
    
}
