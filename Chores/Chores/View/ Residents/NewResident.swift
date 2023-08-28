//
//  NewResident.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 20/08/23.
//

import SwiftUI
import RealmSwift

struct NewResident: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var newResidentViewModel = NewResidentViewModel()
    let isEditing: Bool
    
    @ObservedRealmObject var resident: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Name")
                .font(.title3)
            
            ResidentInputView(residentName: $newResidentViewModel.residentName)
            
            
            
            Text("Prefered Tasks")
                .font(.title3)
            
            List {
                ForEach(TaskCategory.values, id: \.self) { item in
                    MultipleSelectionRow(title: item.rawValue, isSelected: newResidentViewModel.selections.contains(item.rawValue)) {
                        if newResidentViewModel.selections.contains(item.rawValue) {
                            newResidentViewModel.selections.removeAll(where: { $0 == item.rawValue })
                        }
                        else {
                            newResidentViewModel.selections.append(item.rawValue)
                        }
                        
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            
        }
        .alert("", isPresented: $newResidentViewModel.hasError, actions: {
//                    Button("Cancel", role: .cancel) {
//                        isShowingDeleteAlert.toggle()
//                    }
            Button("OK", role: .cancel) {
                newResidentViewModel.hasError = false
            }
        }, message: {
            Text("Please insert a resident name")
        })
        
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle(isEditing ? "Edit Resident" : "New Resident")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
//                    viewModel.addNewTask()
                    print(newResidentViewModel.selections)
                    if isEditing {
                        newResidentViewModel.updateUser(item: resident)
                    } else {
                        newResidentViewModel.addResident()
                    }
                    if newResidentViewModel.hasError == false {
                        dismiss()
                    }
                }, label: {
                    Text("Save")
                })
            }
            
        }
        .onAppear {
            if resident.nickname.count > 0 {
                newResidentViewModel.residentName = resident.nickname
            }
            
            if resident.preferences.count > 0 {
                for item in resident.preferences {
                    newResidentViewModel.selections.append(item.rawValue)
                }
            }
        }
    }

}


struct NewResident_Previews: PreviewProvider {
    static var previews: some View {
    
            Group {
//                NavigationView {
                NewResident(isEditing: false, resident: User())
                        .previewDisplayName("New User")
                    
                    let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking"]])
                    NewResident(isEditing: true, resident: user)
                        .previewDisplayName("Filled")

//                }
            }
            
                
        }
    }


struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        
        Button(action: self.action) {
            HStack {
                if self.isSelected {
                    Image(systemName: "checkmark")
                }
                Text(self.title)
//                    .padding([.leading],50)
                Spacer()
                Image(self.title)
            }
            
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.borderDefaultColor, lineWidth: 1)
        )
    }
}

struct ResidentInputView: View {
    var residentName: Binding<String>
    var body: some View {
        
        VStack {
            
            VStack {
                TextField("Resident name", text: residentName)
            }
        }
        .padding()
        .inputOverlay()
        
    }
}

