//
//  Task.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 24/07/23.
//

import Foundation
import RealmSwift

public enum Types: String, PersistableEnum {
    case none = "None", clothes = "Clothes", cooking = "Cooking", ligthCleaning = "Light cleaning",
         heavyCleaning = "Heavy cleaning", groceries = "Groceries", payments = "Payments", pet = "Pet", custom = "Custom"
}

public enum Repetition: String {
    case never = "Never", everyHour = "Every hour", everyday = "Every day", everyWeekday = "Every weekday",
         everyWeekend = "Every weekend", everyWeek = "Every week", everyMonth = "Every month", everyYear = "Every year"
}

public enum Time: String {
    case hours = "Hours", days = "Days", weeks = "Weeks", months = "Months", years = "Years"
}

final class Task: Object, ObjectKeyIdentifiable {
    
    static let taskOptions: [String] = [Types.none.rawValue, Types.clothes.rawValue, Types.cooking.rawValue,
                                        Types.ligthCleaning.rawValue, Types.heavyCleaning.rawValue, Types.groceries.rawValue,
                                        Types.payments.rawValue, Types.pet.rawValue, Types.custom.rawValue]
    
    static let repetionOptions: [String] = [Repetition.never.rawValue, Repetition.everyHour.rawValue, Repetition.everyday.rawValue,
                                            Repetition.everyWeekday.rawValue, Repetition.everyWeekend.rawValue, Repetition.everyWeek.rawValue,
                                            Repetition.everyMonth.rawValue, Repetition.everyYear.rawValue]
    
    static let timeOptions: [String] = [Time.hours.rawValue, Time.days.rawValue, Time.weeks.rawValue, Time.months.rawValue, Time.years.rawValue]
    
    enum Status: String, PersistableEnum {
        case done, pending, cantDo
    }
    
    enum TaskOwner: String, PersistableEnum {
        case resident, rotation
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var createdAt = Date.now
    @Persisted var startDate: Date
    @Persisted var endRepeatDate: Date
    
    @Persisted var title = ""
    @Persisted var desc = ""
    @Persisted var isImportant = false
    
    // MARK: ENUMS
    @Persisted var type: Types = .none
    @Persisted var status: Status = .pending
    @Persisted var taskOwner: TaskOwner?
    
    @Persisted var taskParticipants = RealmSwift.List<User>()
    
    
    
    func updateStatus(status: Status){
        if let realm = self.realm {
            try? realm.write({
                self.status = status
            })
        }
    }
    
}
