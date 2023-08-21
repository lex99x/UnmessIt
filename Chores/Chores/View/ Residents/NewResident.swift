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
    
    @ObservedRealmObject var resident:User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text("Identification")
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
        .padding()
        .navigationTitle("Add task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
//                    dismiss()
                }, label: {
                    Text("Cancel")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
//                    viewModel.addNewTask()
                    print(newResidentViewModel.selections)
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


let user = User(value: ["nickname":"joaozinho", "preferences":["cooking"]])
struct NewResident_Previews: PreviewProvider {
    static var previews: some View {
    
            Group {
//                NavigationView {
                    NewResident(resident: User())
                        .previewDisplayName("New User")
                    
                    let user = User(value: ["nickname":"joaozinho", "preferences":["Cooking"]])
                    NewResident(resident: user)
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
                Spacer()
                Image(self.title)
            }
            
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.borderBorderDefault, lineWidth: 1)
        )
    }
}

struct ResidentInputView: View {
    var residentName: Binding<String>
    var body: some View {
        
        VStack {
            
            VStack {
                TextField("What should be done", text: residentName)
            }
        }
        .padding()
        .inputOverlay()
        
    }
}

