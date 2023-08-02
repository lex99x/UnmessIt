//
//  TaskDescriptionFieldView.swift
//  Chores
//
//  Created by Alex A. Rocha on 31/07/23.
//

import SwiftUI

struct CustomDescriptionInputView: View {
    
    var whatToDo: Binding<String>
    var howToDo: Binding<String>
    
    var body: some View {
        
        VStack {
            
            VStack {
                TextField("What should be done", text: whatToDo)
            }
            Divider()
            VStack {
                TextField("Describe how it should be done...", text: howToDo)
                    .padding(.bottom, 40)
            }
            
        }
        .padding()
        .inputOverlay()
        
    }
}

struct CustomDescriptionInputView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDescriptionInputView(whatToDo: .constant(""), howToDo: .constant(""))
            .padding()
    }
}
