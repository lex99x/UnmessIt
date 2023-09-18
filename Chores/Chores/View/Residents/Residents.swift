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
    @State private var selection: String? = nil
    
    var body: some View {
        //        NavigationView {
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
                                        print("aaa")
                                        residentsViewModel.deleteItem(item: item)
                                    } label: {
                                        Text("Delete")
                                    }.tint(.red)
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
                .padding()
                .listStyle(.inset)
                
                Spacer()
                
//                NavigationLink(destination:NewResident(isEditing: false, resident: User())) {}
                
//                NavigationLink(destination: NewResident(isEditing: false, isSpaceOwner: false, resident: User()), tag: "A", selection: $selection) { EmptyView() }
                
                Button {
//                    selection = "A"
                    isEditingResident.toggle()
                } label: {
                    HStack {
                        Image("UserAdd")
                        Text("Add Resident")
                        
                    }
                }
                .buttonStyle(CustomButtonStyle(width: .infinity,
                                               foregroundColor: .textInvertColor,
                                               backgroundColor: .accentColor))
                .padding()

                
            }
            .navigationTitle("Residents")
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
//}
struct Residents_Previews: PreviewProvider {
    static var previews: some View {
        
            Residents()
//                .environment(\.realm, RealmHelper.realmA())
        
        
    }
}

