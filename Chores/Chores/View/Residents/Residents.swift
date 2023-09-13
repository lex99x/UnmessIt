//
//  Residents.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift

struct Residents: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var residentsViewModel = ResidentsViewModel()
    @State private var isActive = false
    @State private var showAlert = false
    
    @State private var selection: String? = nil
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    ForEach(residentsViewModel.residents.freeze()) { item in
                        if item.isSpaceOwner {
                            ResidentRow(resident: item)
                                .padding([.top, .bottom], 10)
                                .listRowSeparator(.hidden)
                        } else {
                            ResidentRow(resident: item)
                                .padding([.top, .bottom], 10)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        print(item)
                                        residentsViewModel.deleteItem(item: item)
                                    } label: {
                                        Text("alert_delete_all_tasks_action_right")
                                    }
                                    .tint(.red)
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
                .padding()
                .listStyle(.inset)
                
                Spacer()
                                
                NavigationLink(destination: NewResident(isEditing: false, isSpaceOwner: false, resident: User()), tag: "A", selection: $selection) { EmptyView() }

                Button {
                    selection = "A"
                } label: {
                    Label(title: {
                        Text("residents_button_add_resident")
                            .font(Font.custom(Font.generalSansFontRegular, size: 15))
                            .fontWeight(.medium)
                    }, icon: {
                        Image.userAddIcon
                    })
                    .foregroundColor(.textInvertColor)
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .textInvertColor,
                                               backgroundColor: .accentColor))
                .padding(.horizontal)
                
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image.arrowLeftIcon
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("button_back")
                                .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        }
                        .foregroundColor(.textAccentColor)
                    })
                }
                
                ToolbarItemGroup(placement: .principal) {
                    Text("residents_title")
                        .font(Font.custom(Font.generalSansFontRegular, size: 17))
                        .foregroundColor(.textPrimaryColor)
                }
                
            }
            .toolbarBackground(Color.surfaceSecondaryColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        
    }
    
}

struct Residents_Previews: PreviewProvider {
    static var previews: some View {
        Residents()
    }
}
