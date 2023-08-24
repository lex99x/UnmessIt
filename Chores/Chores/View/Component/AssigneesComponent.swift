//
//  AssigneesComponent.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 23/08/23.
//

import SwiftUI
import RealmSwift
struct AssigneesComponent: View {
    
    let placeholder: String
    let options: RealmSwift.List<User>
        
    @Binding var selectedOption: User
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text(placeholder)
                    .foregroundColor(.textPrimaryColor)
                Spacer()
                Text(selectedOption.nickname)
                    .foregroundColor(.textSecondaryColor)
                
                Menu(content: {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedOption = option
                        }, label: {
                            HStack {
                                Text(option.nickname)
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

//struct AssigneesComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var user = User()
//
//        AssigneesComponent(placeholder: "fodasse", options: [User()])
//    }
//}
