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
    
    var textfield: Binding<String>
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(title)
                .font(Font.custom(Font.generalSansFontRegular, size: 15))
                    
            TextField(placeholder, text: textfield)
                .padding()
                .inputOverlay()
                .background {
                    Color.surfaceSecondaryColor
                }
            
        }
        
    }
    
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(title: "Title",
                            placeholder: "Placeholder here",
                            textfield: .constant(""))
        .padding()
    }
}
