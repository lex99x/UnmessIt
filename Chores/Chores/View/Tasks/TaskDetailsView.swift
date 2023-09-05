//
//  TaskDetailsView.swift
//  Chores
//
//  Created by Alex A. Rocha on 16/08/23.
//

import SwiftUI
import RealmSwift

struct TaskDetailsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedRealmObject var task: Task
    @ObservedObject private var viewModel = TaskDetailViewModel()
    
    @State private var selection: String? = nil
    @State var isShowingDeleteAlert = false
    
    var body: some View {
        
//        NavigationLink(destination: NewTaskView(isEditing: true, task: self.task), tag: "A", selection: $selection) { EmptyView() }
        
        VStack(alignment: .leading, spacing: 16) {
                        
            HStack {
                
                HStack {
                    Task.getTaskIconByCategory(taskCategory: task.category)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.textAccentColor)
                    Text(task.category.rawValue)
                        .foregroundColor(.textPrimaryColor)
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background {
                    Color.surfaceSecondaryColor
                        .clipShape(Capsule())
                }
                
                Spacer()
                
                TaskStatusBadge(status: task.status)
                
            }
                
            Text(task.title)
                .font(Font.custom(Font.generalSansFontRegular, size: 20))
                .fontWeight(.medium)
            
            if !task.desc.isEmpty {
                Text(task.desc)
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
            }
            
            if let assignee = task.assignees.first {
                HStack {
                    Image(systemName: "person")
                        .padding(4)
                        .background {
                            Color.surfaceSecondaryColor
                                .cornerRadius(8)
                        }
                    Text(assignee.nickname)
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .foregroundColor(.textSecondaryColor)
            }
            
            HStack {
                Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 4, height: 4)
                Text(task.createdAt.formatted(date: .omitted, time: .shortened))
            }
            .font(Font.custom(Font.generalSansFontRegular, size: 17))
            .foregroundColor(.textPrimaryColor)
            
            Spacer()
            
            if task.status == .pending {
                
                Button(action: {
                    task.status = .done
                }, label: {
                    HStack {
                        Image.doneStatusIcon
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Mark as done")
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .fontWeight(.medium)
                    }
                })
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .badgeTextDoneColor,
                                               backgroundColor: .badgeSurfaceDoneColor))
                
            } else {
                
                Button(action: {
                    task.status = .pending
                }, label: {
                    HStack {
                        Image.pendingStatusIcon
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Mark as pending")
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .fontWeight(.medium)
                    }
                })
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .badgeTextPendingColor,
                                               backgroundColor: .badgeSurfacePendingColor))
                
            }
            
        }
        .padding(.top, 24)
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image.arrowLeftIcon
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Back")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    }
                    .foregroundColor(.textAccentColor)
                })
            }

            ToolbarItem(placement: .principal) {
                Text("View task")
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    .foregroundColor(.textPrimaryColor)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    Image.editIcon
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.textAccentColor)
                })
            }

        }
        .toolbarBackground(Color.surfaceSecondaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)

    }

}

struct TaskDetailsView_Previews: PreviewProvider {
    
    static let mockedTask = Task(value: ["title": "Take out the trash",
                                         "desc": "Empty all trash cans and take it out before 14h. Don't forget that box for recycling.",
                                         "isImportant": true,
                                         "category": TaskCategory.ligthCleaning,
                                         "startDate": Date.now,
                                         "endRepeatDate": Date.now] as [String : Any])
    
    static var previews: some View {
        NavigationStack {
            TaskDetailsView(task: TaskDetailsView_Previews.mockedTask)
        }
    }
    
}
