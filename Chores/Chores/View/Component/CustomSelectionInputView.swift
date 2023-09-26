//
//  CustomSelectionInputView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct CustomSelectionInputView: View {
    
    @State var placeholder: String
    let options: [String]
    @Binding var selectedOption: String
    
    var body: some View {
        
        Menu(content: {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    self.placeholder = selectedOption
                }, label: {
                    Text(("task_type_" + option.lowercased().replacingOccurrences(of: " ", with: "_")).localized)
                    Image(option)
                        .renderingMode(.original)
                })
            }
        }, label: {
            
            Text(placeholder.localized)
                .foregroundColor(.textPrimaryColor)
            
            if let taskCategory = TaskCategory(rawValue: placeholder) {
                Task.getTaskIconByCategory(taskCategory: taskCategory)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("Category" + taskCategory.rawValue.replacingOccurrences(of: " ", with: "")))
            }
            
            Spacer()
            
            Image.popupButtonIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.textSecondaryColor)
            
        })
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.vertical, 12)
        .padding(.horizontal, 12)
        .inputOverlay()
        
    }
    
}

struct CustomSelectionInputView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CustomSelectionInputView(placeholder: "Select a type...",
                                 options: Task.taskOptions,
                                 selectedOption: .constant(""))
        .padding()
        
    }
    
}
