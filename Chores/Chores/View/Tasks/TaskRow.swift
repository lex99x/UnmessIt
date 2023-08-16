//
//  TaskRow.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 16/08/23.
//

import SwiftUI

struct TaskRow: View {
    var item: Task
    var body: some View {
        ZStack {
            // inside card
            HStack {
                VStack {
                    HStack {
                        // Type image
                        ZStack {
                            Image(item.type.rawValue)
                                .padding(12)
                        }
                        .background(Color(hex: "D6D6D6"))
                        .cornerRadius(16)
                        .padding(12)
                        
                        
                        // Text
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .padding(.bottom, 0.1)
                                .font(.callout)
                            
                            HStack {
                                switch item.createdAt.checkDay() {
                                case .today:
                                    Text("Today")
                                        .font(.subheadline)
                                    
                                case .yesterday:
                                    Text("Yesterday")
                                        .font(.subheadline)
                                    
                                case .tomorrow:
                                    Text("Tomorrow")
                                        .font(.subheadline)
                                case .none:
                                    Text(item.createdAt.toString(format: "dd-MM"))
                                        .font(.subheadline)
                                }
                                
                                Image("Ellipse")
                                .frame(width: 4, height: 4)
                                .background(Color(red: 0.44, green: 0.49, blue: 0.59))
                                    
                                Text("\(item.createdAt.timeIn24HourFormat())")
                                    .font(.subheadline)
                                
                            }
                        }
                    }
                    
                    
                    
                }
                
                Spacer()
                VStack {
                    Spacer()
                    // Status badge
                    TaskStatusBadge(status: item.status)
                        .padding([.bottom, .trailing])
                    
                }
            }
        }
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(Color.borderBorderDefault, lineWidth: 1)
        )
        .background(Color.surfaceSurfaceSecondary)
        .cornerRadius(16)
        
        
        
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let item:Task = .init(value: ["title":"U need to do \(Int.random(in: 0...999))", "status": "done", "createdAt":Date(timeIntervalSinceNow: -60000), "type":"Cooking"])
            
            TaskRow(item: item)
                .frame(width: 358, height: 78)
        }
        
    }
}

extension Date {
    enum check {
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
//        components.day = 1
//        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return components.hour
    }
    
    func checkDay() -> check {
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
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}