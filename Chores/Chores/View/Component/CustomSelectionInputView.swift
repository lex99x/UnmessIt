//
//  CustomPickerView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct CustomSelectionInputView: View {
    
    let placeholder: String
    let options: [String]
        
    @Binding var selectedOption: String
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(placeholder)
                    .foregroundColor(.textPrimaryColor)
                Spacer()
                Text(selectedOption)
                    .foregroundColor(.textSecondaryColor)
                
                if let taskCategory = TaskCategory(rawValue: selectedOption) {
                    Task.getTaskIconByCategory(taskCategory: taskCategory)
                        .frame(width: 16, height: 16)
                }
                
                Menu(content: {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                        }, label: {
                            HStack {
                                Text(option)
                                Task.getTaskIconByCategory(taskCategory: TaskCategory(rawValue: option) ?? TaskCategory.clothes)
                                    .renderingMode(.original)
                            }
                        })
                    }
                }, label: {
                    Image.popupButtonIcon
                        .frame(width: 16, height: 16)
                        .foregroundColor(.textSecondaryColor)
                })
                
            }
            
        }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.vertical)
        .padding(.horizontal, 12)
        .inputOverlay()
        .background {
            Color.surfaceSecondaryColor
        }
        
    }
    
}

struct CustomSelectionInputView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomSelectionInputView(placeholder: "Task type",
                                 options: Task.taskOptions,
                                 selectedOption: .constant(""))
        .padding()
        
    }
    
}
