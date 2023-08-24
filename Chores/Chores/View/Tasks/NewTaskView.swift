//
//  CreateTaskView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI
import RealmSwift

struct NewTaskView: View {
    @ObservedObject var viewModel = NewTaskViewModel()
    
    let isEditing: Bool
    @ObservedRealmObject var task: Task
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        Divider()
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 24) {
                
                CustomSelectionInputView(placeholder: "Task type",
                                         options: Task.taskOptions,
                                         selectedOption: $viewModel.selectedTaskTypeOption)
                
                NewInputView(residentName: $viewModel.titleTextfield)
                
                
                CustomTextFieldView(title: "Description",
                                    placeholder: "How it should be done",
                                    textfield: $viewModel.descriptionTextfield)
                
                
                VStack(alignment: .leading) {
                    Text("Assignee")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    AssigneesComponent(placeholder: "Select a resident",
                                       options: viewModel.selectedSpace!.residents, selectedOption: $viewModel.selectedAssigneeOption)
                }
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle(isEditing == false ? "New Task" : "Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(Font.custom(Font.generalSansFontMedium, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
//                ToolbarItem(placement: .principal) {
//                    Text("New task")
//                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
//                }
//
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if isEditing {
                            viewModel.updateTask(item: task)
                        } else {
                            viewModel.addNewTask()
                        }
                        
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(Font.custom(Font.generalSansFontMedium, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
            }
            

        }
        .onAppear {
            print("fodasse")
            if isEditing == true {
                viewModel.titleTextfield = task.title
                viewModel.descriptionTextfield = task.desc
                viewModel.selectedTaskTypeOption = task.category.rawValue

                // MARK: REFACTOR WHEN HAVE MULTIPLE ASSIGNEERS
                viewModel.selectedAssigneeOption = task.assignees.first!
            }
//
        }
        
    }
        
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Group {
//                NavigationView {
                NewTaskView(isEditing: false, task: Task())
                        .previewDisplayName("New Task")
                    
                var task: Task {
                    let newTask = Task()
                    newTask.title = "foo"
                    newTask.category = .pet
                    return newTask
                }
                    NewTaskView(isEditing: true, task: task)
                        .previewDisplayName("Filled")

//                }
            }
        }
    }
}

struct NewInputView: View {
    var residentName: Binding<String>
    var body: some View {
        
        VStack {
            
            VStack {
                TextField("What should be done", text: residentName)
            }
        }
        .padding()
        .inputOverlay()
        
    }
}
