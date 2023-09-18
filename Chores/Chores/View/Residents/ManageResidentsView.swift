//
//  ManageResidentsView.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift

struct ManageResidentsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var residentsViewModel = ResidentsViewModel()
    @State private var isActive = false
    @State private var showAlert = false
    @State private var isEditingResident = false
    @State private var selection: String? = nil
    
    var body: some View {
            
        VStack {
            
            List {
                Section {
                    ForEach(residentsViewModel.residents.freeze()) { item in
                        if item.isSpaceOwner {
                            ResidentCardView(resident: item)
                                .padding([.top, .bottom], 10)
                                .listRowSeparator(.hidden)
                        } else {
                            ResidentCardView(resident: item)
                                .padding([.top, .bottom], 10)
                                .swipeActions(edge: .trailing) {
                                    Button {
                                        print(item)
                                        residentsViewModel.deleteItem(item: item)
                                    } label: {
                                        Text("delete".localized)
                                    }
                                    .tint(.red)
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                } footer: {
                    Text("residents_subtitle".localized)
                        .font(Font.custom(Font.generalSansFontRegular, size: 15))
                        .foregroundColor(.textSecondaryColor)
                }
            }
            .listStyle(.inset)
            
            Spacer()
                
            Button {
                isEditingResident.toggle()
            } label: {
                HStack {
                    Image.userAddIcon
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("residents_button_add_resident")
                        .fontWeight(.medium)
                }
                .foregroundColor(.textInvertColor)
            }
            .buttonStyle(CustomButtonStyle(width: .infinity,
                                           foregroundColor: nil,
                                           backgroundColor: .accentColor))
            
        }
        .padding(.top, 24)
        .padding(.horizontal)
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
            
            ToolbarItem(placement: .principal) {
                Text("residents_title")
                    .font(Font.custom(Font.generalSansFontRegular, size: 17))
                    .foregroundColor(.textPrimaryColor)
            }
            
        }
        .toolbarBackground(Color.surfaceSecondaryColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .sheet(isPresented: $isEditingResident) {
            NavigationStack {
                NewResident(isEditing: false, isSpaceOwner: false, resident: User())
            }
        }
        
    }
    
}

struct Residents_Previews: PreviewProvider {
    static var previews: some View {
        ManageResidentsView()
    }
}
