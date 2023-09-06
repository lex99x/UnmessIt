//
//  TaskCardView.swift
//  Chores
//
//  Created by Alex A. Rocha on 06/09/23.
//

import SwiftUI

struct TaskCardView: View {
        
    var body: some View {
        
        HStack {
            
            Image.lightCleaningIcon
                .resizable()
                .frame(width: 28, height: 28)
                .padding(.vertical, 22)
                .padding(.horizontal, 11)
                .background {
                    Color.surfaceTertiaryColor
                        .cornerRadius(12)
                }
                .foregroundColor(.categoryLightCleaningColor)
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text("Take out the trash")
                    .fontWeight(.medium)
                    .foregroundColor(.textPrimaryColor)
                
                HStack(spacing: 8) {
                    
                    Image.userIcon
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(4)
                        .background {
                            Color.surfaceTertiaryColor
                                .cornerRadius(8)
                        }
                    
                    Text("Fulano de Tal")
                        .foregroundColor(.textSecondaryColor)
                    
                }
                
                HStack {
                    
                    Text("Today")
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 4, height: 4)
                    Text("12:00")
                    
                    Spacer()
                    
                    TaskStatusBadge(status: .pending)
                    
                }
                .foregroundColor(.textSecondaryColor)
                
            }
            .padding(.leading, 12)
            .padding(.trailing, 4)
            
            Image.chevronRightIcon
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.textSecondaryColor)
            
        }
        .font(Font.custom(Font.generalSansFontRegular, size: 15))
        .padding(.vertical, 12)
        .padding(.leading, 12)
        .padding(.trailing, 4)
        .background {
            Color.surfaceSecondaryColor
                .cornerRadius(16)
        }
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView()
            .padding()
    }
}
