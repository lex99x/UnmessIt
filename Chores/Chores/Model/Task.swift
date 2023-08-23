//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI
import RealmSwift

enum TaskCategory: String, PersistableEnum {
    case clothes, cooking, ligthCleaning, heavyCleaning, groceries, payments, pet
    
    static let values: [TaskCategory] = [.clothes, .cooking, .ligthCleaning, .heavyCleaning, .groceries, .payments, .pet]
}


class Task: Object, ObjectKeyIdentifiable {
    
    enum Status: String, PersistableEnum {
        case done, pending, cantDo
    }
    
    static let taskOptions: [String] = [TaskCategory.clothes.rawValue,
                                        TaskCategory.cooking.rawValue,
                                        TaskCategory.ligthCleaning.rawValue,
                                        TaskCategory.heavyCleaning.rawValue,
                                        TaskCategory.groceries.rawValue,
                                        TaskCategory.payments.rawValue,
                                        TaskCategory.pet.rawValue]

    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var createdAt: Date = .init()
    
    @Persisted var title: String = ""
    @Persisted var desc: String = ""
    
    // MARK: Enums
    @Persisted var category: TaskCategory
    @Persisted var status: Status = .pending
    
    
    @Persisted var assignees = RealmSwift.List<User>()
    
    
    
    // MARK: Removed for V1
    
    //
    //        switch taskCategory {
    //        case .clothes:
    //            return .clothesIcon
    //        case .cooking:
    //            return .cookingIcon
    //        case .ligthCleaning:
    //            return .lightCleaningIcon
    //        case .heavyCleaning:
    //            return .heavyCleaningIcon
    //        case .groceries:
    //            return .groceriesIcon
    //        case .payments:
    //            return .paymentsIcon
    //        case .pet:
    //            return .petsIcon
    //        }
    //
    //    enum TaskOwner: String, PersistableEnum {
    //        case resident, rotation
    //    }
    //
    //    @Persisted var repetitionNumber: Int
    //    @Persisted var repetitionTimePeriod: TimePeriod
    //    @Persisted var endRepeatDate: Date?
    //
    //    @Persisted var isImportant = false
    
    //    static let taskOptions: [String] = [TaskCategory.clothes.rawValue,
    //                                        TaskCategory.cooking.rawValue,
    //                                        TaskCategory.ligthCleaning.rawValue,
    //                                        TaskCategory.heavyCleaning.rawValue,
    //                                        TaskCategory.groceries.rawValue,
    //                                        TaskCategory.payments.rawValue,
    //                                        TaskCategory.pet.rawValue]
    //
    //    static let timePeriodOptions: [String] = [TimePeriod.hours.rawValue,
    //                                              TimePeriod.days.rawValue,
    //                                              TimePeriod.weeks.rawValue,
    //                                              TimePeriod.months.rawValue,
    //                                              TimePeriod.years.rawValue]
    //
    
    //    enum TimePeriod: String, PersistableEnum {
    //    case hours = "Hours", days = "Days", weeks = "Weeks", months = "Months", years = "Years"
    //}

}
