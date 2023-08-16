//
//  TaskRow.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 16/08/23.
//

import SwiftUI

struct TaskRow: View {
    var item: Task
    var body: some View {
        ZStack {
            // inside card
            HStack {
                VStack {
                    HStack {
                        // Type image
                        ZStack {
                            Image(item.type.rawValue)
                                .padding(12)
                        }
                        .background(Color(hex: "D6D6D6"))
                        .cornerRadius(16)
                        .padding(12)
                        
                        
                        // Text
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .padding(.bottom, 0.1)
                                .font(.callout)
                            
                            HStack {
                                Text("Today")
                                    .font(.subheadline)
                                
                                Image("Ellipse")
                                .frame(width: 4, height: 4)
                                .background(Color(red: 0.44, green: 0.49, blue: 0.59))
                                    
                                Text("12:00")
                                    .font(.subheadline)
                                
                            }
                        }
                    }
                    
                    
                    
                }
                
                Spacer()
                VStack {
                    Spacer()
                    // Status badge
                    TaskStatusBadge(status: item.status)
                        .padding([.bottom, .trailing])
                    
                }
            }
        }
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(Color.borderBorderDefault, lineWidth: 1)
        )
        .background(Color.surfaceSurfaceSecondary)
        .cornerRadius(16)
        
        
        
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        let item:Task = .init(value: ["title":"U need to do \(Int.random(in: 0...999))", "status": "done"])
        
        TaskRow(item: item)
            .frame(width: 358, height: 78)
    }
}
