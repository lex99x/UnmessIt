//
//  CustomTextFieldView.swift
//  Chores
//
//  Created by Alex A. Rocha on 27/07/23.
//

import SwiftUI

struct CustomTextFieldView: View {

    let title: String
    let optionalLabel: String?
    let placeholder: String
    
    var textfield: Binding<String>
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(title)
                Spacer()
                
                if let optionalLabel = optionalLabel {
                    Text(optionalLabel)
                        .foregroundColor(.gray)
                }
                
            }
        
            TextField(placeholder, text: textfield)
                .padding()
                .inputOverlay()
            
        }
        
    }
    
}

struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView(title: "Title",
                            optionalLabel: "Optional",
                            placeholder: "Placeholder here",
                            textfield: .constant(""))
        .padding()
    }
}
