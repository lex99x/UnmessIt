//
//  Date+Check.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 20/09/23.
//

import Foundation

extension Date {
    
    enum Check {
        case today, yesterday, tomorrow, none
    }
    
    func timeIn24HourFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func getHour() -> Int? {
        var components = Calendar.current.dateComponents([.hour], from: self)
        return components.hour
    }
    
    func checkDay() -> Check {
        if Calendar.current.isDateInToday(self) {
            return .today
        } else if Calendar.current.isDateInYesterday(self) {
            return .yesterday
        } else if Calendar.current.isDateInTomorrow(self) {
            return .tomorrow
        } else {
            return .none
        }
    }
    
    func startOfMonth() -> Date {
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 1
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    func nextDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
    
    func previousDate() -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -1, to: self)
        return previousDate ?? Date()
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
