//
//  CreateTaskView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI
import RealmSwift

struct NewTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = NewTaskViewModel()
    @State var isShowingDeleteAlert = false
    
    let isEditing: Bool
    @ObservedRealmObject var task: Task
    
    var body: some View {
        
        ScrollView {
            
            Divider()
            
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Task type")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    CustomSelectionInputView(placeholder: isEditing ?  task.category.rawValue : "Select a option...",
                                             options: Task.taskOptions,
                                             selectedOption: $viewModel.selectedTaskTypeOption)
                    .onChange(of: viewModel.selectedTaskTypeOption) { newValue in
                        
                        if let recommendation = viewModel.recommendAssigneer(item: newValue) {
                            viewModel.selectedAssigneeOption = recommendation
                        } else {
                            viewModel.selectedAssigneeOption = User()
                        }
                        
                    }
                }
                
                CustomTextFieldView(title: "Task name",
                                    placeholder: "What should be done...",
                                    isOptional: false,
                                    textfield: $viewModel.titleTextfield)
                
                
                CustomTextFieldView(title: "Description",
                                    placeholder: "How it should be done...",
                                    isOptional: true,
                                    textfield: $viewModel.descriptionTextfield)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("When")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)

                   VStack(alignment: .leading, spacing: 6){
                       DatePicker("Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                        Divider()
                        DatePicker("Time", selection: $viewModel.selectedDate , displayedComponents: .hourAndMinute)
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textPrimaryColor)

                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .inputOverlay()

                }
                    
                VStack(alignment: .leading) {
                    Text("Resident in charge")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    AssigneesInputView(placeholder: isEditing ? task.assignees.first!.nickname : "Select a resident...",
                                       assignees: viewModel.selectedSpace!.residents,
                                       selectedAssignee: $viewModel.selectedAssigneeOption)
                }
                

                .alert("alert_task_missing_fields_title".localized, isPresented: $viewModel.hasError, actions: {
                    Button("alert_task_missing_fields_action".localized, role: .cancel) {
                        viewModel.hasError = false
                    }
                }, message: {
                    Text("alert_task_missing_fields_description")
                })
                    
                // delete task alert
                .alert("alert_delete_all_tasks_title".localized, isPresented: $isShowingDeleteAlert, actions: {
                    Button("alert_delete_all_tasks_action_left".localized, role: .cancel) {
                        isShowingDeleteAlert.toggle()
                    }
                    Button("alert_delete_all_tasks_action_right".localized, role: .destructive) {
                        viewModel.deleteTask(item: task)
                        dismiss()
                    }
                }, message: {
                    Text("alert_delete_all_tasks_description".localized)
                })
                
                Spacer()
                
                if isEditing {
                    Button(action: {
                        isShowingDeleteAlert.toggle()
                    }, label: {
                        Label(title: { Text("Delete Task") }, icon: { Image.deleteIcon })
                    })
                    .buttonStyle(CustomButtonStyle(width: .infinity,
                                                   foregroundColor: .textInvertColor,
                                                   backgroundColor: .accentColor))
                    .padding(.top, 100)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal,16)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text(isEditing ? "Edit task" : "New task")
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .foregroundColor(.textPrimaryColor)
                }
                
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
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
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
            if isEditing {
                viewModel.titleTextfield = task.title
                viewModel.descriptionTextfield = task.desc
                viewModel.selectedAssigneeOption = task.assignees.first!
                viewModel.selectedTaskTypeOption = task.category.rawValue
                viewModel.selectedDate = task.whenDo
//
                // MARK: REFACTOR WHEN HAVE MULTIPLE ASSIGNEERS
//                viewModel.selectedAssigneeOption = task.assignees.first!
                print(task.assignees)
                print([viewModel.selectedTaskTypeOption])
    
            }
        }
        
    }
        
}
struct NewInputView: View {
    var residentName: Binding<String>
    var body: some View {
        VStack {
            VStack {
                TextField("What should be done...", text: residentName)
            }
        }
        .padding()
        .inputOverlay()
        
    }
}


struct NewTaskView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NavigationStack {
            
            NewTaskView(isEditing: true, task: Task())

        }
        
    }
    
}
