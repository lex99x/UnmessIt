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
                    
                    Text("task_input_type_title")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    CustomSelectionInputView(placeholder: isEditing ?  task.category.rawValue : "task_input_type_placeholder".localized,
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
                
                CustomTextFieldView(title: "task_input_name_title".localized,
                                    placeholder: "task_input_name_placeholder".localized,
                                    isOptional: false,
                                    textfield: $viewModel.titleTextfield)
                
                CustomTextFieldView(title: "task_input_description_title".localized,
                                    placeholder: "task_input_description_placeholder".localized,
                                    isOptional: true,
                                    textfield: $viewModel.descriptionTextfield)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("task_input_when_title")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)

                   VStack(alignment: .leading, spacing: 6){
                       DatePicker("task_input_when_date", selection: $viewModel.selectedDate, displayedComponents: .date)
                        Divider()
                        DatePicker("task_input_when_time", selection: $viewModel.selectedDate , displayedComponents: .hourAndMinute)
                    }
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textPrimaryColor)

                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .inputOverlay()
                }
                    
                VStack(alignment: .leading) {
                    Text("task_assignee_title")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    AssigneesInputView(placeholder: isEditing ? task.assignees.first?.nickname ?? "" : "task_assignee_placeholder".localized,
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
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
                    }
                }, message: {
                    Text("alert_delete_all_tasks_description".localized)
                })
                
//                Spacer()
                
                if isEditing {
                    Spacer()
                    Button(action: {
                        isShowingDeleteAlert.toggle()
                    }, label: {
                        
                        HStack {
                            Image.userRemoveIcon
                                .frame(width: 20, height: 20)
                            Text("edit_resident_button_delete")
                                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.textCriticalColor)
                                                
                    })
                    .buttonStyle(CustomButtonStyle(width: .infinity,
                                                   foregroundColor: nil,
                                                   backgroundColor: .surfaceTertiaryColor))
                }
                
            }
            .padding(.top, 26)
            .padding(.horizontal)
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("task_button_cancel")
                            .font(Font.custom(Font.generalSansFontRegular, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
                ToolbarItem(placement: .principal) {
                    Text(isEditing ? "edit_task_title" : "new_task_title")
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
                        Text("task_button_save")
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
                viewModel.selectedAssigneeOption = task.assignees.first ?? User()
                viewModel.selectedTaskTypeOption = task.category.rawValue
                viewModel.selectedDate = task.whenDo
                
//                MARK: REFACTOR WHEN HAVE MULTIPLE ASSIGNEERS
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
                TextField("task_input_name_placeholder", text: residentName)
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
