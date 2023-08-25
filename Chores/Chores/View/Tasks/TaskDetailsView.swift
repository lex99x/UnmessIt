////
////  TaskDetailsView.swift
////  Chores
////
////  Created by Alex A. Rocha on 16/08/23.
////

import SwiftUI
import RealmSwift

struct TaskDetailsView: View {
    
    @ObservedRealmObject var task: Task
    @ObservedObject private var viewModel = TaskDetailViewModel()
    @State private var selection: String? = nil
    @State var isShowingDeleteAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationLink(destination: NewTaskView(isEditing: true, task: self.task), tag: "A", selection: $selection) { EmptyView() }
        
        HStack {
            VStack(alignment: .leading, spacing: 24) {
                
                // MARK: Title + Description
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(task.title)
                        .font(Font.custom(Font.generalSansFontMedium, size: 20))
                    if task.desc.isEmpty{
                        EmptyView()
                    } else {
                        Text(task.desc)
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    }
                }
                
                HStack {
                    Image(systemName: "person")
                    Text(task.assignees.first?.nickname ?? "You")
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .foregroundColor(.textSecondaryColor)
                    
                // MARK: Tags
                HStack(spacing: 8) {
                    
                    HStack {
                        Text(task.category.rawValue)
                            .foregroundColor(.textSecondaryColor)
                        Task.getTaskIconByCategory(taskCategory: task.category)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor(.categoryLightCleaningColor)
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .padding(.vertical, 6)
                    .padding(.horizontal, 8)
                    .inputOverlay()
                    .background {
                        Color.surfaceSecondaryColor
                    }
                    
                    //                if task.isImportant {
                    //
                    //                    HStack {
                    //                        Text("Important task")
                    //                        Image.pinIcon
                    //                            .resizable()
                    //                            .frame(width: 16, height: 16)
                    //                    }
                    //                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    //                    .foregroundColor(.textSecondaryColor)
                    //                    .padding(.vertical, 6)
                    //                    .padding(.horizontal, 8)
                    //                    .inputOverlay()
                    //                    .background {
                    //                        Color.surfaceSecondaryColor
                    //                    }
                    //
                    //                }
                    
                }
                
                HStack {
                    
                    Text(task.createdAt.formatted(date: .abbreviated, time: .omitted))
                    Spacer()
                    Text("One time task")
                    
                    
                }
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .foregroundColor(.textPrimaryColor)
                .padding()
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
                
                Spacer()
                
            }
//            .border(.red, width: 1)
            .padding(.top, 24)
            .navigationTitle("View task")
            .navigationBarTitleDisplayMode(.inline)
            
            Spacer()
            
        }
        .padding(.horizontal)
        
        .toolbar {
            //
            //                ToolbarItem(placement: .navigationBarLeading) {
            //                    Button(action: {}, label: {
            //                        HStack {
            //                            Image.arrowLeftIcon
            //                            Text("Back")
            //                        }
            //                        .foregroundColor(.textAccentColor)
            //                    })
            //                }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                // MARK: REMOVED TO V1
                //                    Button(action: {
                //                        selection = "A"
                //                    }, label: {
                //                        Image.editIcon
                //                            .foregroundColor(.textAccentColor)
                //                    })
                Button(action: {
                    isShowingDeleteAlert.toggle()
                }, label: {
                    Image.deleteIcon
                        .foregroundColor(.textCriticalColor)
                })
                .alert("Delete task", isPresented: $isShowingDeleteAlert, actions: {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        viewModel.deleteTask(item: task)
                        dismiss()
                    }
                }, message: {
                    Text("This action cannot be undone.\nAre you sure you want to delete it?")
                })
            }
            
        }
        
    }

}

struct TaskDetailsView_Previews: PreviewProvider {
    
    static let mockedTask = Task(value: ["title": "Take ou the trash",
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
