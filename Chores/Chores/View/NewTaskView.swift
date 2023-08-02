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
        
        Divider()
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                CustomSelectionInputView(placeholder: "Task type",
                                         options: viewModel.taskOptions,
                                         selectedOption: $viewModel.selectedOption)
                .padding(.bottom, 24)
                
                Text("Identification")
                    .font(.title3)
                    .padding(.bottom, 16)
                
                CustomDescriptionInputView(whatToDo: $viewModel.whatToDo,
                                         howToDo: $viewModel.howToDo)
                .padding(.bottom, 16)
                
                Toggle("Important", isOn: $viewModel.isImportantToggleOn)
                    .foregroundColor(.gray)
                    .padding()
                    .inputOverlay()
                
                Text("When it will happen")
                    .font(.title3)
                    .padding(.top, 16)
                
                DatePicker("Date and time", selection: $viewModel.selectedDate)
                    .padding()
                    .foregroundColor(.gray)
                    .inputOverlay()
                
                CustomSelectionInputView(placeholder: "Repeat",
                                         options: viewModel.repetionOptions,
                                         selectedOption: $viewModel.selectedRepetionOption)
                .padding(.top, 16)
                
                Text("Who should do it")
                    .font(.title3)
                    .padding(.top, 24)
                
                CustomSelectionInputView(placeholder: "Assignees",
                                         options: viewModel.assigneeOptions,
                                         selectedOption: $viewModel.selectedAssigneeOption)
                
//                Spacer()
                
            }
            .padding()
            .navigationTitle("New task")
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
