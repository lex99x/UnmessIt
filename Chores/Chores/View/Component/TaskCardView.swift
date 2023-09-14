//
//  TaskCardView.swift
//  Chores
//
//  Created by Alex A. Rocha on 06/09/23.
//

import SwiftUI
import RealmSwift

struct CategoryBadgeView: View {
    
    let category: TaskCategory
    
    var body: some View {
        
        Task.getTaskIconByCategory(taskCategory: category)
            .resizable()
            .frame(width: 24, height: 24)
            .padding(.vertical, 22)
            .padding(.horizontal, 11)
            .foregroundColor(Color("Category" + category.rawValue.replacingOccurrences(of: " ", with: "")))
            .background {
                Color.surfaceTertiaryColor
                    .cornerRadius(12)
            }
        
    }
    
}

struct TaskCardView: View {
        
    @ObservedRealmObject var task: Task
    
    var body: some View {
        
        HStack {
                        
            CategoryBadgeView(category: task.category)
                .padding(12)
                                                
            VStack(alignment: .leading, spacing: 6) {
                
                Text(task.title)
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimaryColor)
                
                HStack(spacing: 8) {
                    
                    Image.userIcon
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(4)
                        .background {
                            Color.surfaceTertiaryColor
                                .cornerRadius(8)
                        }
                    
                    Text(task.assignees.first?.nickname ?? "no_assignee".localized)
                        .foregroundColor(.textSecondaryColor)
                    
                }
                
                HStack {
                    
                    Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                        .fixedSize()
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 4, height: 4)
                    Text(task.createdAt.formatted(date: .omitted, time: .shortened))
                        .fixedSize()
                    
                    Spacer()
                    
                    TaskStatusBadge(status: task.status)
                    
                }
                .foregroundColor(.textSecondaryColor)
                
            }
                                                        
            Image.chevronRightIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.textSecondaryColor)
                .padding(.trailing, 4)
                        
        }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.25)
                .stroke(Color.borderDefaultColor, lineWidth: 0.5)
        )
        .background {
            Color.surfaceSecondaryColor
                .cornerRadius(16)
        }

    }
    
}

extension Task {
    
    static let mockedTask = Task(value: ["title": "Title",
                                         "desc": "Lorem ipsum dolor",
                                         "category": TaskCategory.clothes,
                                         "status": Task.Status.pending] as [String : Any])
    
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(task: Task.mockedTask)
            .padding()
    }
}
