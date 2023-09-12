//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import SwiftUI
import RealmSwift

enum TaskCategory: String, PersistableEnum {
    case none, clothes = "Clothes", cooking = "Cooking", ligthCleaning = "Light Cleaning",
              heavyCleaning = "Heavy Cleaning", organization = "Organization", payments = "Payments", pets = "Pets", shopping = "Shopping"

    static let values: [TaskCategory] = [.clothes, .cooking, .ligthCleaning, .heavyCleaning, .organization, .payments, .pets, .shopping]
}


class Task: Object, ObjectKeyIdentifiable {
    
    enum Status: String, PersistableEnum {
        case done, pending, cantDo
    }
    
    static let taskOptions: [String] = [TaskCategory.clothes.rawValue,
                                        TaskCategory.cooking.rawValue,
                                        TaskCategory.ligthCleaning.rawValue,
                                        TaskCategory.heavyCleaning.rawValue,
                                        TaskCategory.organization.rawValue,
                                        TaskCategory.payments.rawValue,
                                        TaskCategory.pets.rawValue,
                                        TaskCategory.shopping.rawValue]

    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var createdAt: Date = .init()
    @Persisted var whenDo: Date = .init()
    
    @Persisted var title: String = ""
    @Persisted var desc: String = ""
    
    // MARK: Enums
    @Persisted var category: TaskCategory
    @Persisted var status: Status = .pending
    
    
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
            case .organization:
                return .organizationIcon
            case .payments:
                return .paymentsIcon
            case .pets:
                return .petsIcon
            case .shopping:
                return .shoppingIcon
            case .none:
                return .petsIcon
        }
        
    }
    
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
