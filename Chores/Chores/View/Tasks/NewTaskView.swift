//
//  CreateTaskView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct NewTaskView: View {
        
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = NewTaskViewModel()
    
    var body: some View {
        
        Divider()
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 24) {
                
                CustomSelectionInputView(placeholder: "Task type",
                                         options: Task.taskOptions,
                                         selectedOption: $viewModel.selectedTaskTypeOption)
                
                CustomTextFieldView(title: "Task name",
                                    placeholder: "Take out the trash",
                                    textfield: $viewModel.titleTextfield)
                
                CustomTextFieldView(title: "Description",
                                    placeholder: "How it should be done",
                                    textfield: $viewModel.descriptionTextfield)
                
                Toggle("Important", isOn: $viewModel.isImportantToggleOn)
                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    .foregroundColor(.textPrimaryColor)
                    .padding()
                    .inputOverlay()
                    .background {
                        Color.surfaceSecondaryColor
                    }
                
                VStack(alignment: .leading) {
                    
                    Text("When")
                        .font(Font.custom(Font.generalSansFontMedium, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    
                    DatePicker("Date and time", selection: $viewModel.selectedStartDate)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                        .padding()
                        .inputOverlay()
                        .background {
                            Color.surfaceSecondaryColor
                        }
                    
                }
                
                VStack {
                    
                    Toggle("Recurrent task", isOn: $viewModel.isRecurrentToggleOn)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                    
                    if viewModel.isRecurrentToggleOn {
                        
                        Divider()
                        
                        HStack {
                            
                            Text("Repeats every")
                            Spacer()
                            Text("\(viewModel.selectedTimeOption)")
                                .padding(.trailing, .zero)
                            
                            if viewModel.selectedTimeOption == 1 {
                                Text("\(viewModel.selectedRepetionOption.lowercased().replacingOccurrences(of: "s", with: ""))")
                            } else {
                                Text("\(viewModel.selectedRepetionOption.lowercased())")
                            }
                            
                        }
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textPrimaryColor)
                        .padding(.top, 11)
                        
                        HStack {
                            
                            Picker("", selection: $viewModel.selectedTimeOption)
                            {
                                ForEach(1...12, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("", selection: $viewModel.selectedRepetionOption)
                            {
                                ForEach(Task.timePeriodOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                        }
                        
                        Divider()
                        
                        Toggle("End repeat", isOn: $viewModel.isEndRepeatToggleOn)
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .foregroundColor(.textPrimaryColor)
                            .padding(.top, 11)
                        
                        if viewModel.isEndRepeatToggleOn {
                            
                            Divider()
                            
                            DatePicker("Repeats until", selection: $viewModel.selectedEndRepeatDate, displayedComponents: .date)
                                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                .foregroundColor(.textPrimaryColor)                                .padding(.top, 11)
                            
                        }
                        
                    }
                    
                }
                .padding()
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
                
            }
            .padding()
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
                
                ToolbarItem(placement: .principal) {
                    Text("New task")
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
//                        viewModel.addNewTask()
                    }, label: {
                        Text("Save")
                            .font(Font.custom(Font.generalSansFontMedium, size: 17))
                            .foregroundColor(.textAccentColor)
                    })
                }
                
            }
            
        }
        
    }
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewTaskView()
        }
    }
}
