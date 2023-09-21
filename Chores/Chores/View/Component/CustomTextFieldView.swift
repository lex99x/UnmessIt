//
//  CustomTextFieldView.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomTextFieldView: View {

    let title: String
    let placeholder: String
    
    let isOptional: Bool
    var textfield: Binding<String>
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                
                Text(title)
                    .font(Font.custom(Font.generalSansFontMedium, size: 15))
                    .foregroundColor(.textPrimaryColor)
                
                if isOptional {
                    Spacer()
                    Text("optional")
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textSecondaryColor)
                }
                
            }

            TextField(placeholder, text: textfield)
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                .padding(12)
                .inputOverlay()
            
        }
        
    }
    
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(title: "Title",
                            placeholder: "Placeholder here",
                            isOptional: true,
                            textfield: .constant(""))
        .padding()
    }
}
