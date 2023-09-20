//
//  ResidentCardView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift

struct ResidentCardView: View {
    
    @ObservedRealmObject var resident: User
    @State var isEditingResident = false
    
//    @Binding var isSpaceOwner: Bool
//    var threeColumnGrid = [GridItem(.fixed(50)),
//                           GridItem(.fixed(50)),
//                           GridItem(.fixed(50)),
//                           GridItem(.fixed(50)),
//                           GridItem(.fixed(50))]
    
    var columns = [GridItem(.adaptive(minimum: 35))]
    
    var body: some View {
        
        HStack {
            Button { isEditingResident.toggle() } label: {
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text(resident.localizedNickname())
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .fontWeight(.medium)
                        .foregroundColor(.textPrimaryColor)
                    
                    ZStack {
                        
                        HStack {
                            Spacer()
                            Image.chevronRightIcon
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.textSecondaryColor)
                        }
                        .offset(y: -18)
                        
                        HStack {
                            if resident.preferences.isEmpty {
                                Text("residents_tap_to_add")
                                    .font(Font.custom(Font.generalSansFontRegular, size: 15))
                                    .foregroundColor(.textSecondaryColor)
                                Spacer()
                            } else {
                                HStack(alignment: .lastTextBaseline) {
                                    LazyVGrid(columns: columns) {
                                        ForEach(resident.preferences, id: \.self) { item in
                                            PreferenceItem(imageName: item.rawValue)
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                            
                }
                .padding(12)
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

struct PreferenceItem: View {
    var imageName: String
    var body: some View {
        ZStack {
            VStack {
                Image(imageName)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 16, height: 16)
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

struct ResidentRow_Previews: PreviewProvider {
    static var previews: some View {
        ResidentCardView(resident: User.mockedUser)
            .padding()
    }
}
