//
//  TaskDetailsView.swift
//  Chores
//
//  Created by Alex A. Rocha on 16/08/23.
//

import SwiftUI
import RealmSwift
import AVFoundation

struct TaskDetailsView: View {
    let selectionFeedback = UISelectionFeedbackGenerator()
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedRealmObject var task: Task
    @ObservedObject private var viewModel = TaskDetailViewModel()
    
    @State private var selection: String? = nil
    @State var isShowingDeleteAlert = false
    @State private var isActive = false
    
    var body: some View {
        
//        NavigationLink(destination: NewTaskView(isEditing: true, task: self.task), tag: "A", selection: $selection) { EmptyView() }
        
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                
                TaskCategoryBadge(taskCategory: task.category)
                Spacer()
                TaskStatusBadge(status: task.status)
                
            }
            
            Text(task.title)
                .font(Font.custom(Font.generalSansFontMedium, size: 20))
            
            if !task.desc.isEmpty {
                Text(task.desc)
                    .font(Font.custom(Font.generalSansFontRegular, size: 16))
            }
            
            if let assignee = task.assignees.first {
                if !assignee.nickname.isEmpty {
                    HStack {
                        Image.userIcon
                            .padding(4)
                            .background {
                                Color.surfaceSecondaryColor
                                    .cornerRadius(8)
                            }
                        Text(assignee.localizedNickname())
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textSecondaryColor)
                }
            }
            
            HStack {
                Text(task.whenDo.formatted(date: .abbreviated, time: .omitted))
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 4, height: 4)
                Text(task.whenDo.formatted(date: .omitted, time: .shortened))
            }
            .font(Font.custom(Font.generalSansFontRegular, size: 16))
            .foregroundColor(.textPrimaryColor)
            
            Spacer()
            
            Button(action: {
                if task.status == .done {
                    viewModel.updateStatus(item: task, status: .pending)
                    isActive = false
                } else {
                    viewModel.updateStatus(item: task, status: .done)
//                    playSounds("done_sound")
                    isActive = true
                    
                    selectionFeedback.prepare()
                    selectionFeedback.selectionChanged()
                }
                    
            }, label: {
                HStack {
                    if task.status == .done {
                        Image.pendingStatusIcon
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.badgeTextPendingColor)

                    } else {
                        Image.doneStatusIcon
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.badgeTextDoneColor)

                    }

                    
                    if(task.status == .done) {
                        Text("view_task_button_pending")
                            .foregroundColor(.badgeTextPendingColor)
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    } else {
                        Text("view_task_button_done")
                            .foregroundColor(.badgeTextDoneColor)
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    }
                }
                
                
            }
                
            )
            .buttonStyle(task.status == .done ? 
                        CustomButtonStyle(width: .infinity,
                                           foregroundColor: .badgeTextPendingColor,
                                           backgroundColor: .badgeSurfacePendingColor) 
                        :
                        CustomButtonStyle(width: .infinity,
                                          foregroundColor: .badgeTextDoneColor,
                                          backgroundColor: .badgeSurfaceDoneColor)
            )
            .particleEffect(image: "star", status: isActive, activeTint: .badgeTextDoneColor, inactiveTint: .gray)
            
            
            
        }
        
        .sheet(isPresented: $viewModel.isAddingNewTask, onDismiss: {
            if viewModel.didDeleteTask {
                dismiss()
            }
        }) {
            NavigationStack {
                NewTaskView(isEditing: true, didDeleteTask: $viewModel.didDeleteTask, task: task)
            }
        }
        
        .padding(.top, 16)
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
                        Text("button_back")
                            .font(Font.custom(Font.generalSansFontRegular, size: 16))
                    }
                    .foregroundColor(.textAccentColor)
                })
            }
            
            ToolbarItem(placement: .principal) {
                Text("view_task_title")
                    .font(Font.custom(Font.generalSansFontRegular, size: 16))
                    .foregroundColor(.textPrimaryColor)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.isAddingNewTask.toggle()
                }, label: {
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
    
    static var previews: some View {
        NavigationStack {
            TaskDetailsView(task: Task.mockedTask)
        }
    }
    
}
