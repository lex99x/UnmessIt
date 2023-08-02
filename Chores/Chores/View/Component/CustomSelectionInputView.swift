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
    
    @Binding var selectedOption: String?
    
    var body: some View {
        
        HStack {
            
            Text(placeholder)
            Spacer()
            
            if let selectedOption = selectedOption {
                Text(selectedOption)
            }
            
            Menu(content: {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }, label: {
                        Text(option)
//                        Label(option, systemImage: "person.circle")
                    })
                }
            }, label: {
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(.gray)
            })
            
        }
        .foregroundColor(.gray)
        .padding()
        .inputOverlay()
        
    }
    
}

struct CustomSelectionInputView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let options: [String] = [Types.clothes.rawValue,
                                 Types.pet.rawValue,
                                 Types.cooking.rawValue]
        
        CustomSelectionInputView(placeholder: "Task type",
                         options: options,
                         selectedOption: .constant(nil))
        .padding()
        
    }
    
}
