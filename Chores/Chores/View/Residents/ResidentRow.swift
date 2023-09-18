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
    @State var isEditingResident = false
//    @Binding var isSpaceOwner: Bool
//     var threeColumnGrid = [GridItem(.fixed(50)), GridItem(.fixed(50)), GridItem(.fixed(50)),GridItem(.fixed(50)),GridItem(.fixed(50))]
    var columns = [GridItem(.adaptive(minimum: 35))]
    var body: some View {
//        NavigationLink(destination: NewResident(isEditing: true, isSpaceOwner: resident.isSpaceOwner ? true : false, resident: resident)) {
                // inside card
                HStack {
                    Button {isEditingResident.toggle()} label: {
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
                                        Text("residents_card_description".localized)
                                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                            .foregroundColor(.textSecondaryColor)
                                        Spacer()
                                    } else {
                                        HStack(alignment:.lastTextBaseline) {
                                            LazyVGrid(columns: columns) {
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
                        
                        
                        
//                    }
                    
                    
                    //                VStack {
                    //                    Spacer()
                    //                    // Status badge
                    //                    TaskStatusBadge(status: item.status)
                    //                        .padding([.bottom, .trailing])
                    //
                    //                }
                }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.borderDefaultColor, lineWidth: 1)
            )
            .background {
                Color.surfaceSecondaryColor
            }
            .cornerRadius(16)
        }
        .sheet(isPresented: $isEditingResident) {
            NavigationStack {
                NewResident(isEditing: true, isSpaceOwner: resident.isSpaceOwner ? true : false, resident: resident)
            }
        }
        
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
            VStack {
                Image(imageName)
                    .renderingMode(.original)
                    .resizable().frame(width: 16, height: 16)
            }
            .padding(2)
        }
        .padding(8)
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.borderDefaultColor, lineWidth: 1)
        )
    }
}

