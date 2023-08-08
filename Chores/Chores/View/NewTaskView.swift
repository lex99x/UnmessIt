//
//  CreateTaskView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct NewTaskView: View {
    
    @ObservedObject var viewModel = NewTaskViewModel()
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 24) {
                
                CustomSelectionInputView(placeholder: "Task type",
                                         options: Task.taskOptions,
                                         selectedOption: $viewModel.selectedOption)
                
                Text("Identification")
                    .font(.title3)
                
                CustomDescriptionInputView(whatToDo: $viewModel.whatToDo,
                                           howToDo: $viewModel.howToDo)
                
                Toggle("Important", isOn: $viewModel.isImportantToggleOn)
                    .foregroundColor(.gray)
                    .padding()
                    .inputOverlay()
                
                Text("When it will happen")
                    .font(.title3)
                
                DatePicker("Date and time", selection: $viewModel.selectedDate)
                    .padding()
                    .foregroundColor(.gray)
                    .inputOverlay()
                
                VStack {
                    
                    Toggle("Recurrent task", isOn: $viewModel.isRecurrentToggleOn)
                        .foregroundColor(.gray)
                    
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
                        .padding(.top, 11)
                        .foregroundColor(.gray)
                        
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
                                ForEach(Task.timeOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                        }
                        
                        Divider()
                        
                        Toggle("End repeat", isOn: $viewModel.isEndRepeatToggleOn)
                            .foregroundColor(.gray)
                            .padding(.top, 11)
                        
                        if viewModel.isEndRepeatToggleOn {
                            
                            Divider()
//                                .padding(.top, 11)
                            
                            DatePicker("Repeats until", selection: $viewModel.selectedEndRepeatDate, displayedComponents: .date)
                                .foregroundColor(.gray)
                                .padding(.top, 11)
                            
                        }
                        
                    }
                    
                }
                .padding()
                .inputOverlay()
                
                Text("Who should do it")
                    .font(.title3)
                
                CustomSelectionInputView(placeholder: "Assignees",
                                         options: viewModel.assigneeOptions,
                                         selectedOption: $viewModel.selectedAssigneeOption)
                
            }
            .padding()
            .navigationTitle("Add task")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .customBackground()
        
    }
    
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewTaskView()
        }
    }
}
