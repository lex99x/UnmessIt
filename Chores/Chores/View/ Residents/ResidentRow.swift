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
     var threeColumnGrid = [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50))]
    var body: some View {
        NavigationLink(destination: NewResident(isEditing: true, resident: resident)) {
            ZStack {
                // inside card
                HStack {
                    VStack {
                        HStack {
                            // Text
                            VStack(alignment: .leading) {
                                Text(resident.nickname)
                                    .padding(.bottom, 0.1)
                                    .font(Font.custom(Font.generalSansFontMedium, size: 17))
                                    .foregroundColor(.textPrimaryColor)
                                
                                HStack {
                                    if resident.preferences.isEmpty {
                                        Text("Tap to add your preferences.")
                                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                            .foregroundColor(.textSecondaryColor)
                                    }
                                    HStack(alignment:.lastTextBaseline) {
                                        LazyVGrid(columns: threeColumnGrid, spacing: 8) {
                                            ForEach(resident.preferences, id:\.self) {item in
                                                PreferenceItem(imageName: item.rawValue)
                                                    .padding([.trailing, .leading], 1)
                                        }
                                        }
                                        
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
            .background {
                Color.surfaceSecondaryColor
            }
            .cornerRadius(16)
        }
        
    }
}

struct ResidentRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let user = User(value: ["nickname":"joaozinho"])
            ResidentRow(resident: user)
                .frame(width: 358, height: 78)
        }
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
