//
//  TaskCardView.swift
//  Chores
//
//  Created by Alex A. Rocha on 06/09/23.
//

import SwiftUI
import RealmSwift

struct TaskCardView: View {
        
    @ObservedRealmObject var task: Task
    
    var body: some View {
        
        HStack {
            
            Task.getTaskIconByCategory(taskCategory: task.category)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.vertical, 22)
                .padding(.horizontal, 11)
                .foregroundColor(Color("Category" + task.category.rawValue.replacingOccurrences(of: " ", with: "")))
                .background {
                    Color.surfaceTertiaryColor
                        .cornerRadius(12)
                }
            
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
                    
                    if let assignee = task.assignees.first {
                        Text(assignee.nickname)
                            .foregroundColor(.textSecondaryColor)
                    }
                    
                }
                
                HStack {
                    
                    Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 4, height: 4)
                    Text(task.createdAt.formatted(date: .omitted, time: .shortened))
                    
                    Spacer()
                    
                    TaskStatusBadge(status: task.status)
                    
                }
                .foregroundColor(.textSecondaryColor)
                
            }
            .padding(.leading, 12)
            .padding(.trailing, 4)
            
            Image.chevronRightIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.textSecondaryColor)
            
        }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.vertical, 12)
        .padding(.leading, 12)
        .padding(.trailing, 4)
        .background {
            Color.surfaceSecondaryColor
                .cornerRadius(16)
        }
        
    }
    
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(task: Task.mockedTask)
            .padding()
    }
}
