//
//  ResidentRow.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift
struct ResidentRow: View {
    @ObservedRealmObject var resident: User
    
    var body: some View {
        ZStack {
            // inside card
            HStack {
                VStack {
                    HStack {
                        // Text
                        VStack(alignment: .leading) {
                            Text(resident.nickname)
                                .padding(.bottom, 0.1)
                                .font(.headline)

                            HStack {
                                ForEach(resident.preferences, id:\.self) {item in
//                                    Text("Hahahaha")
                                    PreferenceItem(imageName: item.rawValue)
                                }
                            }
                        }
                    }
                    
                    
                    
                }
                
                Spacer()
//                VStack {
//                    Spacer()
//                    // Status badge
//                    TaskStatusBadge(status: item.status)
//                        .padding([.bottom, .trailing])
//
//                }
            }
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 16)
            .stroke(Color.borderBorderDefault, lineWidth: 1)
        )
        .background(Color.surfaceSurfaceSecondary)
        .cornerRadius(16)
        
        
        
    }
}

struct ResidentRow_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking"]])
        ResidentRow(resident: user)
            .frame(width: 358, height: 78)
    }
}

struct PreferenceItem: View {
    var imageName: String
    var body: some View {
        ZStack {
            Image(imageName)
        }
        .padding(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderBorderDefault, lineWidth: 1)
        )
    }
}
