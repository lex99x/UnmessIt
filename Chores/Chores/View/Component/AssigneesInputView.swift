//
//  AssigneesInputView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 23/08/23.
//

import SwiftUI
import RealmSwift

struct AssigneesInputView: View {
    
    @State var placeholder: String
    let assignees: RealmSwift.List<User>
    @Binding var selectedAssignee: User
    
    var body: some View {
                
        Menu(content: {
            ForEach(assignees, id: \.self) { option in
                Button(action: {
                    selectedAssignee = option
                    placeholder = selectedAssignee.nickname
                }, label: {
                    HStack {
                        Text(option.nickname)
                    }
                })
            }
        }, label: {
            
            Text(placeholder)
                .foregroundColor(.textPrimaryColor)
            
            Spacer()
            
            Image.popupButtonIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.textSecondaryColor)
        })
        .onChange(of: selectedAssignee) { newValue in
            if !newValue.nickname.isEmpty {
                placeholder = newValue.nickname
            }
            }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.vertical)
        .padding(.horizontal, 12)
        .inputOverlay()
        
    }
}

struct AssigneesComponent_Previews: PreviewProvider {
    
    static var previews: some View {
    
        AssigneesInputView(placeholder: "Select a resident...",
                           assignees: List<User>(),
                           selectedAssignee: .constant(User()))
        .padding()
        
    }
    
}
