//
//  TaskItem.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 04/08/23.
//

import SwiftUI

struct TaskItem: View {
    
     var item: Task
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            
            
            
            ZStack {
                VStack {
                 Image(systemName: "circle")
                        .padding([.leading, .trailing],11)
                        .padding([.top, .bottom],42)
                        
                }
            }
            .background(Color.taskTypeBackgroudn)
            .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("Take out the trash")
                  .font(
                    Font.custom("SF Pro Text", size: 17)
                      .weight(.medium)
                  )
//                  .foregroundColor(Constants.Neutrals700)
                  .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(alignment: .center, spacing: 6) {
                    Image(systemName: "person")
                    .frame(width: 16, height: 16)
                    
                    Text("Fulano de Tal")
                    .font(Font.custom("SF Pro Text", size: 15))
                    .foregroundColor(Color(red: 0.44, green: 0.49, blue: 0.59))
                }
                .padding(0)
                
                HStack(alignment: .center) {
                // Space Between
                    Text("Today")
                      .font(Font.custom("SF Pro Text", size: 15))
                      .foregroundColor(Color(red: 0.44, green: 0.49, blue: 0.59))
                    
                    Image("Ellipse")
                    .frame(width: 4, height: 4)
                    .background(Color(red: 0.44, green: 0.49, blue: 0.59))
                    
                    Text("12:00")
                      .font(Font.custom("SF Pro Text", size: 15))
                      .foregroundColor(Color(red: 0.44, green: 0.49, blue: 0.59))
                Spacer()
                    
                    TaskStatusBadge(status: self.item.status)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(16)
        .background(Color(red: 0.93, green: 0.93, blue: 0.98))
        .cornerRadius(16)
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(.black, lineWidth: 0)
        )
    }

}
