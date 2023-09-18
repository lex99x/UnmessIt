//
//  Residents.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 21/08/23.
//

import SwiftUI
import RealmSwift

struct Residents: View {
    
    @ObservedObject private var residentsViewModel = ResidentsViewModel()
    @State private var isActive = false
    @State private var showAlert = false
    @State private var isEditingResident = false
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Section {
                        ForEach(residentsViewModel.residents.freeze()) { item in
                            if item.isSpaceOwner {
                                ResidentRow(resident: item)
                                    .padding([.top, .bottom], 10)
                                    .listRowSeparator(.hidden)
                            } else {
                                ResidentRow(resident: item)
                                    .padding([.top, .bottom], 10)
                                    .listRowSeparator(.hidden)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        
                    } footer: {
                        Text("residents_subtilte".localized)
                    }
                }
                .padding()
                .listStyle(.inset)
                
                Spacer()
                Button {
                    isEditingResident.toggle()
                } label: {
                    HStack {
                        Image.userAddIcon
                        Text("residents_button_add_resident".localized)
                        
                    }
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .textInvertColor,
                                               backgroundColor: .accentColor))
                .padding()

                
            }
            .navigationTitle("residents_title".localized)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.surfaceSecondaryColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            
            .sheet(isPresented: $isEditingResident) {
                NavigationStack {
                    NewResident(isEditing: false, isSpaceOwner: false, resident: User())
                }
            }
        }
    }
}

struct Residents_Previews: PreviewProvider {
    static var previews: some View {
        
            Residents()
        
        
    }
}

