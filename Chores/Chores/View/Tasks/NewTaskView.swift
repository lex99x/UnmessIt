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
        
        ScrollView {
            
            Divider()
            
            VStack(alignment: .leading, spacing: 24) {
                
                CustomSelectionInputView(placeholder: "Task type",
                                         options: Task.taskOptions,
                                         selectedOption: $viewModel.selectedTaskTypeOption)
                .onChange(of: viewModel.selectedTaskTypeOption) { newValue in
                    
                    if let recommendation = viewModel.recommendAssigneer(item: newValue) {
                        viewModel.selectedAssigneeOption = recommendation
                    } else {
                        viewModel.selectedAssigneeOption = User()
                    }
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Task title")
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    NewInputView(residentName: $viewModel.titleTextfield)
                        .background {
                            Color.surfaceSecondaryColor
                        }
                }
                
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
                
                
                .alert("alert_task_missing_fields_title".localized, isPresented: $viewModel.hasError, actions: {
//                    Button("Cancel", role: .cancel) {
//                        isShowingDeleteAlert.toggle()
//                    }
                    Button("alert_task_missing_fields_action".localized, role: .cancel) {
                        viewModel.hasError = false
                    }
                }, message: {
                    Text("alert_task_missing_fields_description")
                })
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationTitle(isEditing == false ? "New task" : "Edit task")
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
                        if viewModel.hasError == false {
                            dismiss()
                        }
                    }, label: {
                        Text("Save")
                            .font(Font.custom(Font.generalSansFontMedium, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
            }
            

        }
        .background {
            Color.surfaceSheetColor
                .ignoresSafeArea()
        }
        .onAppear {
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
                    newTask.category = .pets
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
