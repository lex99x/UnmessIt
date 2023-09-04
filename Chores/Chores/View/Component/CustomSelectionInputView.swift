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
                                
                Menu(content: {
                    ForEach(options, id: \.self) { option in
                        Button(role: .cancel, action: {
                            selectedOption = option
                        }, label: {
                            Text(option)
                            Image(option)
                                .renderingMode(.original)
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
        .onAppear {
            print("Category" + options.last!.replacingOccurrences(of: " ", with: ""))
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
